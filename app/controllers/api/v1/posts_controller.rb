class Api::V1::PostsController < ApplicationController
  #before_action :authenticate_user!
  before_action :find_post, only: [:show, :update, :destroy]
 
  def index
    @posts = Post.all
    render json: @posts, include: [:comments, :likes]
  end

  def show
    @post = Post.find(params[:id])
    render json:  @post, include: [:comments, :likes]
  end

  def create

    puts "KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK"
    puts "KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK"
    puts "KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK"
    puts params
    puts current_user.id

    puts "KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK"
    puts "KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK"
    puts "KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK"

    if params[:post][:image] == ''
      @post = Post.new(
      title: params[:post][:title],
      content: params[:post][:content],
      user_id: current_user.id,
      author: current_user.username,
    )
    else 
      @post = Post.new(post_params)
      @post.user_id: current_user.id
    end

    #@post = Post.new(post_params)

    #@post = Post.new(post_params)
    if @post.save!
      render json: @post, include: [:comments, :likes]
      puts "MMMMMMMMMMMMMMMMMMMMMMMMMMMM"
      puts "IT ACTUALLY SAVED !!"
      puts "MMMMMMMMMMMMMMMMMMMMMMMMMMMM"
    else
      render error: { error: 'error'}, status: 400
      puts "MMMMMMMMMMMMMMMMMMMMMMMMMMMM"
      puts "IT ACTUALLY SAVED !!"
      puts "MMMMMMMMMMMMMMMMMMMMMMMMMMMM"
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
    
    puts "KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK"
    puts "KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK"
    puts "KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK"
    puts params
    puts "KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK"
    puts "KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK"
    puts "KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK"
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



   private

   def post_params
    params.require(:post).permit(:user_id, :title, :content, :image, :id, :image_link, :image_url, :author)
   end

   def find_post
    @post = Post.find(params[:id])
   end

end