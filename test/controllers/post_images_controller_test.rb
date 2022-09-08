require "test_helper"

class PostImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_image = post_images(:one)
  end

  test "should get index" do
    get post_images_url, as: :json
    assert_response :success
  end

  test "should create post_image" do
    assert_difference('PostImage.count') do
      post post_images_url, params: { post_image: { user_id: @post_image.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show post_image" do
    get post_image_url(@post_image), as: :json
    assert_response :success
  end

  test "should update post_image" do
    patch post_image_url(@post_image), params: { post_image: { user_id: @post_image.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy post_image" do
    assert_difference('PostImage.count', -1) do
      delete post_image_url(@post_image), as: :json
    end

    assert_response 204
  end
end
