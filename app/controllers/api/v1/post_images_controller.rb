class Api::V1::PostImagesController < ApplicationController
  before_action :set_post_image, only: [:show, :update, :destroy]

  # GET /post_images
  def index
    @post_images = PostImage.all.select{|el| el.user_id === current_user.id}

    render json: @post_images
  end

  # GET /post_images/1
  def show
    render json: @post_image
  end

  # POST /post_images
  def create

    @user = User.all.find(params[:user_id])
    #@user = User.all.find_by_id(params[:post_id])

    @post_image = PostImage.new(
      user_id: params[:user_id],
      link: params[:link]
    )
    @user.post_images.push(@post_image)

    if @user.save
      render json: @user, include: [:post_images]
    else
      render error: { error: 'Unable to create User.'}, status: 400
    end
  end

  # PATCH/PUT /post_images/1
  def update
    if @post_image.update(post_image_params)
      render json: @post_image
    else
      render json: @post_image.errors, status: :unprocessable_entity
    end
  end

  # DELETE /post_images/1
  def destroy
    @post_image.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_image
      @post_image = PostImage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_image_params
      params.require(:post_image).permit(:user_id)
    end
end
