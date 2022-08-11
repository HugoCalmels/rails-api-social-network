require "test_helper"

class CommonFriendshipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @common_friendship = common_friendships(:one)
  end

  test "should get index" do
    get common_friendships_url, as: :json
    assert_response :success
  end

  test "should create common_friendship" do
    assert_difference('CommonFriendship.count') do
      post common_friendships_url, params: { common_friendship: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show common_friendship" do
    get common_friendship_url(@common_friendship), as: :json
    assert_response :success
  end

  test "should update common_friendship" do
    patch common_friendship_url(@common_friendship), params: { common_friendship: {  } }, as: :json
    assert_response 200
  end

  test "should destroy common_friendship" do
    assert_difference('CommonFriendship.count', -1) do
      delete common_friendship_url(@common_friendship), as: :json
    end

    assert_response 204
  end
end
