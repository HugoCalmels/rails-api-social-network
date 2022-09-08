class Api::V1::ThumbnailsController < ApplicationController
  before_action :set_thumbnail, only: [:show, :update, :destroy]

  # GET /thumbnails
  def index
    @thumbnails = Thumbnail.all

    render json: @thumbnails
  end

  # GET /thumbnails/1
  def show
    render json: @thumbnail
  end

  # POST /thumbnails
  def create
    @thumbnail = Thumbnail.new(thumbnail_params)

    if @thumbnail.save
      render json: @thumbnail, status: :created, location: @thumbnail
    else
      render json: @thumbnail.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /thumbnails/1
  def update
    if @thumbnail.update(thumbnail_params)
      render json: @thumbnail
    else
      render json: @thumbnail.errors, status: :unprocessable_entity
    end
  end

  # DELETE /thumbnails/1
  def destroy
    @thumbnail.destroy
  end

  def createThumbnail
    @thumbnail = Thumbnail.new(thumbnail_params)

    if @thumbnail.save
      render json: @thumbnail, status: :created, location: @thumbnail
    else
      render json: @thumbnail.errors, status: :unprocessable_entity
    end
  end

  def latestThumbnail
    @thumbnail = Thumbnail.last
    render json: ThumbnailSerializer.new(@thumbnail).serializable_hash[:data][:attributes]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_thumbnail
      @thumbnail = Thumbnail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def thumbnail_params
      params.require(:thumbnail).permit(:user_id, :image, :image_url)
    end
end
