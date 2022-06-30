class Api::V1::FriendshipsController < ApplicationController

  def index
    @friendships = User.find_by_id(params[:user_id]).friendships

    @friendlist = []
    @friendships.each do |friend, i|
      puts "OOOOOOOOOOOOOOOOOOOOOOOOO"
      puts "friend nb:",i
      puts "friend userId:", friend.user_id
      puts "friend friendId:", friend.friend_id
      User.all.select do |user|
        puts "AAA"
        puts user.id

        if user.id == friend.friend_id
     
          @friendlist.push(user)
        end
        puts "AAA"
      end
      puts "OOO"
    end
    puts @friendlist
    render json: @friendlist
    # mes friendships restent bloquées dans le /user quand meme.
    #render @friendships pas mal aussi
    # a voir pk ca delete pas correctement, s'il faudrait pas faire plus de méthodes sur le controller.
  end

  def create
    user = User.find_by(id: friendship_params[:user_id])
    friend = User.find_by(id: friendship_params[:friend_id])
    if user.friends.include?(friend)
      render json: {error: "friendship already exists in the database"}
    else
      friendship1 = user.friendships.build(friend_id: friend.id)
      friendship2 = friend.friendships.build(friend_id: user.id)
      
      if friendship1.save && friendship2.save
        render json: {message: "friendship was successfully created"}
      else
        render json: {message: "friendship could not be saved"}
      end
    end
  end


  def destroy
    puts "HELO.....??????????????????"
    @friendship = Friendship.all.find_by_id(params[:id])
    puts @friendship



    @friendship.destroy
    if @friendship.destroy 
    
      render json: {message: 'friendship destroyed !'}
    else
      render json: {message: @friendship.errors.messages}
    end
  end

  private
def friendship_params
  params.require(:friendship).permit(:friend_id, :user_id)
end
end
