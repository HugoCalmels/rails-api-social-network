class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:update]

  def index
    @users = User.all
    render json: @users, include: [ :friendships, :received_invitations, :sent_invitations, :posts]
  end

  def show
    @user = User.find(params[:id])
    render json: @user, include: [ :friendships, :received_invitations, :sent_invitations, :posts]
  end

  def receiveRandomInvitations
    puts "TESTTTTTTTTTT"
    puts "TESTTTTTTTTTT"
    puts "TESTTTTTTTTTT"
    puts "TESTTTTTTTTTT"
    puts "TESTTTTTTTTTT"
    puts "TESTTTTTTTTTT"
    puts "TESTTTTTTTTTT"
    puts "TESTTTTTTTTTT"
  end



  def update
    if @user.update(user_params)
      render json: @post, include: [ :friendships, :received_invitations, :sent_invitations, :posts]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def updateLastSeen
    @user = User.all.find(current_user.id)

    @user.last_seen = params[:time]
    @user.save


    render json: {message: "user last_seen updated"}
  end

  def getAllUsernames

    @users = User.all.collect(&:username)

    render json: @users
  end

  def getUserByEmail

    email = params[:email]+'.'+params[:format]
    @test = User.where("email = ?", email)

    @user = User.where("email = ?", email).first
    render json: @user

  end

  def suggestions
    current_user_friends = current_user.friends
    owners_ids = []
    suggestions = []
    res = current_user_friends
    render json: res
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:id, :username, :email, :avatar_link, :thumbnail_link, :post_images, :posts, :received_invitations, :sent_invitations, :friendships)
  end


end