require "test_helper"

class ThumbnailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @thumbnail = thumbnails(:one)
  end

  test "should get index" do
    get thumbnails_url, as: :json
    assert_response :success
  end

  test "should create thumbnail" do
    assert_difference('Thumbnail.count') do
      post thumbnails_url, params: { thumbnail: { user_id: @thumbnail.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show thumbnail" do
    get thumbnail_url(@thumbnail), as: :json
    assert_response :success
  end

  test "should update thumbnail" do
    patch thumbnail_url(@thumbnail), params: { thumbnail: { user_id: @thumbnail.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy thumbnail" do
    assert_difference('Thumbnail.count', -1) do
      delete thumbnail_url(@thumbnail), as: :json
    end

    assert_response 204
  end
end
