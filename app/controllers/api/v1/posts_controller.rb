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

    puts "9999999999999999999999999999999999999"
    puts "9999999999999999999999999999999999999"
    puts "9999999999999999999999999999999999999"
    puts params[:post][:has_to_be_displayed]
    puts "9999999999999999999999999999999999999"
    puts "9999999999999999999999999999999999999"
    puts "9999999999999999999999999999999999999"




    #@post = Post.new(post_params)
    if @post.save
      render json: @post, include: [:comments, :likes]
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
      puts "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
      puts "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
      puts "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
      puts "HAS TO BE DESTROY SHOULD RETURN TRUE HERE"
      puts params
      puts "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
      puts "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
      puts "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"


    end
  
    #@post = Post.last
    #render json: PostSerializer.new(@post).serializable_hash[:data][:attributes]
    
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

  def getAllPostImagesFromUser

    @posts = Post.all.select{|el| el.user_id === current_user.id}
  

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