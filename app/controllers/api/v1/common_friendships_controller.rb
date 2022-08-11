class Api::V1::CommonFriendshipsController < ApplicationController
  before_action :set_common_friendship, only: [:show, :update, :destroy]

  # GET /common_friendships
  def index

   

    ## The first array 
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
          puts "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
          puts "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
          puts "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
          puts el.id, el.username
          puts "-------------"
          puts some_friend.id, some_friend.username
          puts "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
          puts "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
          puts "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
          el.id == some_friend.id
        end

 
        puts " ??????????????????"
        common_friends.each do |common_friend|
          puts "from user:" +current_user_friend.username
          puts "common_friend: "+common_friend.username
          common_friend.common_friendship_id = c.id
          common_friend.save
          owners_ids.push(current_user_friend.id)
            #current_user_friend
         #someoneFriendlist.friendlist.push(common_friend)
        
        end
        puts " ??????????????????"

        puts "!!!!!!!!!!!!!!!!!!!!!!!!!"
        puts someoneFriendlist
        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!"
        
  
      end

    end


    lddd = CommonFriendship.all.where(owner_id: [owners_ids])

    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%"
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%"
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%"
    puts owners_ids
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%"
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%"
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%"


    render json: lddd, include: [:users]
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

    CommonFriendship.all.each do |friendship|
      friendship.destroy
    end

    ## The first array 
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
          puts "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
          puts "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
          puts "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
          puts el.id, el.username
          puts "-------------"
          puts some_friend.id, some_friend.username
          puts "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
          puts "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
          puts "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
          el.id == some_friend.id
        end

 
        puts " ??????????????????"
        common_friends.each do |common_friend|
          puts "from user:" +current_user_friend.username
          puts "common_friend: "+common_friend.username
          common_friend.common_friendship_id = c.id
          common_friend.save
          owners_ids.push(current_user_friend.id)
            #current_user_friend
         #someoneFriendlist.friendlist.push(common_friend)
        
        end
        puts " ??????????????????"

        puts "!!!!!!!!!!!!!!!!!!!!!!!!!"
        puts someoneFriendlist
        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!"
        
  
      end

    end


    lddd = CommonFriendship.all.where(owner_id: [owners_ids])

    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%"
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%"
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%"
    puts owners_ids
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%"
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%"
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%"


    render json: lddd, include: [:users]
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
