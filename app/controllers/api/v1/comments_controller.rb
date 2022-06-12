class Api::V1::CommentsController < ApplicationController
  before_action :find_comment, only: [:show, :update, :destroy]
  def index
    @comments = Comment.all
    render json: @comments
  end

  def show
    @comment = Comment.find(params[:id])
    render json: @comment
  end

  def create

  puts "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
  puts "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
  puts "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
  puts current_user.id
  puts params[:post_id]
  puts params[:comment][:content]
  test3 = Post.all.find_by_id(params[:post_id])
  puts test3.author
  puts "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
  puts "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
  puts "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
    @post = Post.all.find_by_id(params[:post_id])

    @comment = Comment.new(
      content: params[:comment][:content],
      user_id: current_user.id,
      post_id: params[:post_id]
    )

    @post.comments.push(@comment)

    #puts @post.comments

    #@comment = Comment.new(comment_params)
    if @post.save
      render json: @post, include: [:comments, :likes]
    else
      render error: { error: 'Unable to create User.'}, status: 400
    end
  end

  def destroy
    if @comment && @comment.user_id === current_user.id
      @comment.destroy
      render json: { message: 'Comment successfully deleted.'}, status: 200
    else 
      render json: { error: 'Unable to delete fact.'}, status: 400
    end

  end


  def update
    if @comment
      @comment.update(comment_params)
      render json: {message: 'Fact successfully updated.'}, status: 200
    else 
      render json: { error: 'Unable to update fact.'}, status: 400
    end
  end


   private

   def comment_params
    params.require(:comment).permit(:user_id, :content)
   end

   def find_comment
    @comment = Comment.find(params[:id])
   end

end