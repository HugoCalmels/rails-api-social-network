class Api::V1::PostsController < ApplicationController
  
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
      author: current_user.email
    )
    #@post = Post.new(post_params)
    if @post.save
      render json: @post
    else
      render error: { error: 'Unable to create User.'}, status: 400
    end
  end


   private

   def post_params
    params.require(:post).permit(:user_id, :title, :content)
   end
end