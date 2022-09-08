class Api::V1::LikesController < ApplicationController
  before_action :find_like, only: [:show, :update, :destroy]
  def index
    @likes = Like.all
    render json: @likes
  end

  def show
    @like = Like.find(params[:id])
    render json: @like
  end

  def create
    @post = Post.all.find_by_id(params[:post_id])

    @like = Like.new(
      user_id: current_user.id,
      post_id: params[:post_id]
    )


     if @post.likes.any? {|like| like.user_id == current_user.id}
     
      render error: { error: 'Already liked.'}, status: 400
    else  
      @post.likes.push(@like)
      @post.save
      render json:  @post, include: [:likes, :user, :comments =>{:include =>:user}]
    end


  end

  def destroy
    @post = Post
    if @like && @like.user_id === current_user.id

      @like.destroy
      @post = Post.all.find_by_id(params[:post_id])
      render json:  @post, include: [:likes, :user, :comments =>{:include =>:user}]

    else 
      render json: { error: 'Unable to delete fact.'}, status: 400
    end

  end


  def update
    if @like
      @like.update(like_params)
      render json: {message: 'Fact successfully updated.'}, status: 200
    else 
      render json: { error: 'Unable to update fact.'}, status: 400
    end
  end


   private

   def like_params
    params.require(:like).permit(:user_id, :content)
   end

   def find_like
    @like = Like.find(params[:id])
   end

end