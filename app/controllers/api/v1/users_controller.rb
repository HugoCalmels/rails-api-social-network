class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:update]

  def index
    @users = User.all
    render json: @users, include: [ :friendships, :received_invitations, :sent_invitations]
  end

  def show
    @user = User.find(params[:id])
    render json: @user, include: [ :friendships, :received_invitations, :sent_invitations]
  end

  def update
    if @user.update(user_params)
      render json: @post, include: [ :friendships, :received_invitations, :sent_invitations]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
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