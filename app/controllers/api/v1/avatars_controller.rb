class Api::V1::AvatarsController < ApplicationController
  before_action :set_avatar, only: [:show, :update, :destroy]

  # GET /avatars
  def index
    @avatars = Avatar.all

    render json: @avatars
  end

  # GET /avatars/1
  def show
    render json: @avatar
  end

  # POST /avatars
  def create
    @avatar = Avatar.new(avatar_params)

    if @avatar.save
      render json: @avatar, status: :created, location: @avatar
    else
      render json: @avatar.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /avatars/1
  def update
    if @avatar.update(avatar_params)
      render json: @avatar
    else
      render json: @avatar.errors, status: :unprocessable_entity
    end
  end

  # DELETE /avatars/1
  def destroy
    @avatar.destroy
  end

  def createAvatar
    @avatar = Avatar.new(avatar_params)
    if @avatar.save
      render json: @avatar, status: :created, location: @avatar
    else
      render json: @avatar.errors, status: :unprocessable_entity
    end
  end

  def latestAvatar
    @avatar = Avatar.last
    render json: AvatarSerializer.new(@avatar).serializable_hash[:data][:attributes]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_avatar
      @avatar = Avatar.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def avatar_params
      params.require(:avatar).permit(:user_id, :image, :image_url)
    end
end
