class Api::V1::CommonFriendshipsController < ApplicationController
  before_action :set_common_friendship, only: [:show, :update, :destroy]

  # GET /common_friendships
  def index

      CommonFriendship.all.each do |friendship|
    
       friendship.destroy
      
      end

    ## The first array 
    current_user_friends_list = current_user.friends
    owners_ids = []

    friends_ids= []
    res = []



    current_user_friends_list.each do |current_user_friend|
      friendship1 = Friendship.all.find do |el|
        current_user.id == el.user_id && el.friend_id == current_user_friend.id 
      end
      friendship2 = Friendship.all.find do |el|
        current_user_friend.id  == el.user_id && el.friend_id == current_user.id 
      end
      c = CommonFriendship.create(owner: current_user_friend, owner_username: current_user_friend.username, owner_avatar_link: current_user_friend.avatar_link, invitation:friendship1.id.to_s+","+friendship2.id.to_s)
      common_friends = []

      current_user_friend.friends.each do |some_friend|
        current_user_friends_list.each do |friend|
          if friend.id == some_friend.id
            common_friends.push(friend)
          end
        end
      end

      #######################
      # me faut une table de jointure, chaque user a un seul cf, et annule les autres...
      #MIGRATION A FAIRE
      #######################
      puts "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
      puts "amis en commun avec : " + current_user_friend.username
     common_friends.each do |friend|
     
      a = AssoFriendship.create(user_id: friend.id, common_friendship_id: c.id)
      puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
      puts friend.username
      puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
     end
     
     
     #common_friends.each do |common_friend|
       #   common_friend.common_friendship_id = c.id
       #   common_friend.save
       #   owners_ids.push(current_user_friend.id)
      #end

    #######################

    end

    lddd = CommonFriendship.all.where(owner_id: [owners_ids])
    tstt = CommonFriendship.all

    test555 = CommonFriendship.all.sort_by { |obj| obj.users.length }.reverse

    # jarrive rentrer plusieurs users dans 1 cf, mais je dois jouer avec les friendship_id ?
    #u = User.last
    #u2 = User.first
    #cay = CommonFriendship.last
    #u.common_friendship_id =cay.id
    #u2.common_friendship_id =cay.id
    #u2.save
    #u.save
    #cay.save

    #CommonFriendship.all.each do |friendship|
     #if friendship.users.length == 0 
    #   friendship.destroy
     # end
     # end

    # lets say current user & user 2

   

    render json: test555, include: [:users]
  end

  #################################################################################

  def selectedUserCM

    CommonFriendship.all.each do |friendship|
    
      friendship.destroy
     
     end

   ## The first array 

   puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
   puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
   puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
   puts params
   user = User.find_by_username(params[:username])

   puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
   puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
   puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@"
   current_user_friends_list = user.friends
   owners_ids = []

   friends_ids= []
   res = []



   current_user_friends_list.each do |current_user_friend|
     friendship1 = Friendship.all.find do |el|
      user.id == el.user_id && el.friend_id == current_user_friend.id 
     end
     friendship2 = Friendship.all.find do |el|
       current_user_friend.id  == el.user_id && el.friend_id == user.id 
     end
     c = CommonFriendship.create(owner: current_user_friend, owner_username: current_user_friend.username, owner_avatar_link: current_user_friend.avatar_link, invitation:friendship1.id.to_s+","+friendship2.id.to_s)
     common_friends = []

     current_user_friend.friends.each do |some_friend|
       current_user_friends_list.each do |friend|
         if friend.id == some_friend.id
           common_friends.push(friend)
         end
       end
     end

     #######################
     # me faut une table de jointure, chaque user a un seul cf, et annule les autres...
     #MIGRATION A FAIRE
     #######################
     puts "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
     puts "amis en commun avec : " + current_user_friend.username
    common_friends.each do |friend|
    
     a = AssoFriendship.create(user_id: friend.id, common_friendship_id: c.id)
     puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
     puts friend.username
     puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    end
    
    
    #common_friends.each do |common_friend|
      #   common_friend.common_friendship_id = c.id
      #   common_friend.save
      #   owners_ids.push(current_user_friend.id)
     #end

   #######################

   end

   lddd = CommonFriendship.all.where(owner_id: [owners_ids])
   tstt = CommonFriendship.all

   test555 = CommonFriendship.all.sort_by { |obj| obj.users.length }.reverse

   # jarrive rentrer plusieurs users dans 1 cf, mais je dois jouer avec les friendship_id ?
   #u = User.last
   #u2 = User.first
   #cay = CommonFriendship.last
   #u.common_friendship_id =cay.id
   #u2.common_friendship_id =cay.id
   #u2.save
   #u.save
   #cay.save

   #CommonFriendship.all.each do |friendship|
    #if friendship.users.length == 0 
   #   friendship.destroy
    # end
    # end

   # lets say current user & user 2

  

   render json: test555, include: [:users]
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
