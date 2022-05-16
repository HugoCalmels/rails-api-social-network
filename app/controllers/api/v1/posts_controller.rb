class Api::V1::PostsController < ApplicationController
  before_action :find_post, only: [:show, :update, :destroy]
  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def create
    @post = Post.new(
      title: params[:post][:title],
      content: params[:post][:content],
      user_id: current_user.id,
      author: current_user.username
    )
    #@post = Post.new(post_params)
    if @post.save
      render json: @post
    else
      render error: { error: 'Unable to create User.'}, status: 400
    end
  end

  def destroy
    puts "#############################"
    puts "#############################"
    puts "#############################"
    puts @post.user_id
    puts current_user.id
    puts "#############################"
    puts "#############################"
    puts "#############################"
    if @post && @post.user_id === current_user.id
      @post.destroy
      render json: { message: 'Post successfully deleted.'}, status: 200
    else 
      render json: { error: 'Unable to delete fact.'}, status: 400
    end

  end


  def update
    if @post && @post.user_id === current_user.id
      @post.update(post_params)
      render json: {message: 'Fact successfully updated.'}, status: 200
    else 
      render json: { error: 'Unable to update fact.'}, status: 400
    end
  end



   private

   def post_params
    params.require(:post).permit(:user_id, :title, :content)
   end

   def find_post
    @post = Post.find(params[:id])
   end

end