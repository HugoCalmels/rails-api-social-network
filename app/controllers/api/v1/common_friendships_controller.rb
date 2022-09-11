class Api::V1::CommonFriendshipsController < ApplicationController
  before_action :set_common_friendship, only: [:show, :update, :destroy]

  # GET /common_friendships
  def index
 
    data = []
    current_user_list_of_friends_ids = current_user.friends.map {|el|el.id}
  
     current_user.friends.map do |friend|
        res = friend.friends.filter do |el|
          el.id != current_user.id &&  current_user_list_of_friends_ids.exclude?(el.id)
        end
        guy = {owner_id: friend.id, owner_username: friend.username, owner_avatar_link: friend.avatar_link}
        guy[:users] = res
        data.push(guy)
     end
  
     render json: data
  end

  #################################################################################

  def selectedUserCM

  
  selected_user = User.find_by_username(params[:username])
  data = []
  selected_user_list_of_friends_ids = selected_user.friends.map {|el|el.id}
  current_user_list_of_friends_ids = current_user.friends.map {|el|el.id}

   selected_user.friends.map do |friend|
      if selected_user.id != friend.id
      guy = {owner_id: friend.id, owner_username: friend.username, owner_avatar_link: friend.avatar_link}
      res = friend.friends.filter do |el|
        el.id != current_user.id &&  selected_user_list_of_friends_ids.exclude?(el.id)
      end
      if current_user_list_of_friends_ids.include?(friend.id)
        guy[:users] = res
      else 
        guy[:users] = []
      end
      data.push(guy)
    end
   end

   render json: data

  end


  # GET /common_friendships/1
  def show
    render json: @common_friendship
  end

  # POST /common_friendships
  def create
    @common_friendship = CommonFriendship.new(common_friendship_params)

    if @common_friendship.save
      render json: @common_friendship, status: :created, location: @common_friendship
    else
      render json: @common_friendship.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /common_friendships/1
  def update
    if @common_friendship.update(common_friendship_params)
      render json: @common_friendship
    else
      render json: @common_friendship.errors, status: :unprocessable_entity
    end
  end

  # DELETE /common_friendships/1
  def destroy
    @common_friendship.destroy
  end


  ####
  def suggestions
    current_user_friends_list = current_user.friends
    owners_ids = []

    current_user_friends_list.each do |current_user_friend|
      temp_friends_array = []
      c = CommonFriendship.create(owner: current_user_friend)
      someoneFriendlist = {
        owner: current_user_friend.username,
        friendlist: []
      }
      current_user_friend.friends.each do |some_friend|
     
        common_friends = current_user_friends_list.select do |el|

          el.id != some_friend.id
        end
      end
    end
    render json: common_friends
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_common_friendship
      @common_friendship = CommonFriendship.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def common_friendship_params
      params.fetch(:common_friendship, {})
    end
end
