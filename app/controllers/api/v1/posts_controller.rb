class Api::V1::PostsController < ApplicationController
  #before_action :authenticate_user!
  before_action :find_post, only: [:show, :update, :destroy]
 
  def index
    friendsIds = current_user.friends.map {|el|el.id}
    @posts = Post.all.filter do |post|
      post.user_id.in?(friendsIds) || post.user_id == current_user.id
    end
    @postsTest2 = Kaminari.paginate_array(@posts.reverse()).page(params[:page]).per(5)
    render json: @postsTest2, include: [:likes, :user, :comments =>{:include =>:user}]
  end

  def show
    @post = Post.find(params[:id])
    render json:  @post, include: [:likes, :user, :comments =>{:include =>:user}]
  end

  def getOnlySelectedUserPosts
    @user = User.all.find_by_username(params[:username])
     @posts = @user.posts
     @postsTest2 = Kaminari.paginate_array(@posts.reverse()).page(params[:page]).per(3)
     render json:  @postsTest2, include: [:likes, :user, :comments =>{:include =>:user}] 
  end

  def create
    if params[:post][:image] == ''
      @post = Post.new(
      title: params[:post][:title],
      content: params[:post][:content],
      user_id: current_user.id,
      author: current_user.username,
      has_to_be_displayed: false
    )
    else 
      @post = Post.new(
      title: params[:post][:title],
      content: params[:post][:content],
      user_id: current_user.id,
      author: current_user.username,
      image: params[:post][:image],
      has_to_be_displayed: false
    )
    end
  
    if @post.save
      render json:  @post, include: [:likes, :user, :comments =>{:include =>:user}]
    else
      render error: { error: 'Unable to create User.'}, status: 400
    end
  end

  def removePostDisplay 
    @post = Post.last
    if @post && @post.user_id === current_user.id
      @post.has_to_be_displayed = true
      @post.save
      render json: { message: 'Post successfully deleted.'}, status: 200
    else 
      render json: { error: 'Unable to delete fact.'}, status: 400
    end
  end

  def destroy
    if @post && @post.user_id === current_user.id
      @post.destroy
      render json: { message: 'Post successfully deleted.'}, status: 200
    else 
      render json: { error: 'Unable to delete fact.'}, status: 400
    end

  end


  def update

    if @post.id != Post.last.id
    end

    if @post && @post.user_id === current_user.id
      @post.update(post_params)
      render json: {message: 'Fact successfully updated.'}, status: 200
    else 
      render json: { error: 'Unable to update fact.'}, status: 400
    end
  end

  def latest
    @post = Post.last
    render json: PostSerializer.new(@post).serializable_hash[:data][:attributes]
  end

  def getAllPostImagesFromUser
    @posts = User.all.find_by_id(current_user.id).posts
    render json: @posts, include: [:comments, :likes]
  end

   private

   def post_params
    params.require(:post).permit(:user_id, :title, :content, :image, :id, :image_link, :image_url, :author, :has_to_be_displayed)
   end

   def find_post
    @post = Post.find(params[:id])
   end

end