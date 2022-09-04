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
    puts "IIIIIIIIIIIIIIIII"
    puts "IIIIIIIIIIIIIIIII"
    puts "IIIIIIIIIIIIIIIII"
    puts "IIIIIIIIIIIIIIIII"
    puts "IIIIIIIIIIIIIIIII"
    puts "IIIIIIIIIIIIIIIII"
    puts "IIIIIIIIIIIIIIIII"
    puts "IIIIIIIIIIIIIIIII"
    puts "IIIIIIIIIIIIIIIII"
    puts "IIIIIIIIIIIIIIIII"
    puts "IIIIIIIIIIIIIIIII"
    puts "IIIIIIIIIIIIIIIII"

  end

  def getUserByEmail

    email = params[:email]+'.'+params[:format]
 

    @user = User.all.find_by_email(email)

    render json: @user

  end

  def suggestions
    current_user_friends = current_user.friends
    owners_ids = []
    suggestions = []

    # i have only the friends ID & Usernames
    # i need their friendlists

    res = current_user_friends
    puts "OOOOOOOOOOOOOOOOOOOOOOOOOOOO"
    current_user_friends.each do |friend|
      puts"zzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
     puts friend.username
     puts friend.id
     
     puts"zzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
    end
    puts "OOOOOOOOOOOOOOOOOOOOOOOOOOOO"

   

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