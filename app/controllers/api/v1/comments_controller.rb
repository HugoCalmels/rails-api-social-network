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
  puts current_user.username
  puts current_user.username
  puts current_user.username
  puts current_user.username
  puts "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
  puts "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
  puts "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
    @post = Post.all.find_by_id(params[:post_id])

    @comment = Comment.new(
      content: params[:comment][:content],
      user_id: current_user.id,
      post_id: params[:post_id], 
      author: current_user.username,
    )

    @post.comments.push(@comment)

    #puts @post.comments

    #@comment = Comment.new(comment_params)
    if @post.save
      render json:  @post, include: [:likes, :user, :comments =>{:include =>:user}]
    else
      render error: { error: 'Unable to create User.'}, status: 400
    end
  end

  def destroy
    @post = Post.all.find_by_id(params[:post_id])

    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts @post
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"

    if @comment && @comment.user_id === current_user.id
      @comment.destroy
      render json:  @post, include: [:likes, :user, :comments =>{:include =>:user}]
    else 
      render json: { error: 'Unable to delete fact.'}, status: 400
    end

  end


  def update

    puts "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
    puts "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
    puts "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
    puts "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
    puts "ENTERING UPDATE METHOD"
    puts params
    puts "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
    puts "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
    puts "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
    puts "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
    puts "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"

    foundPost = Post.all.find_by_id(params[:post_id])

    if @comment
      @comment.update(comment_params)
      render json:  foundPost, include: [:likes, :user, :comments =>{:include =>:user}]
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