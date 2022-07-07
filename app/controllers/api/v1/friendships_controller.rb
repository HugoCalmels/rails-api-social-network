class Api::V1::FriendshipsController < ApplicationController

  def index
    @friendships = User.find_by_id(params[:user_id]).friendships

    render json: @friendships, include: [:friend]
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
    puts "HELO.....??????????????????"
    puts "HELO.....??????????????????"
    puts "HELO.....??????????????????"
    puts "HELO.....??????????????????"

    @friendship = Friendship.all.find_by_id(params[:id])

    puts @friendship.id

    puts "HELO.....??????????????????"
    puts "HELO.....??????????????????"

    if @friendship.destroy 
    
      render json: {message: 'friendship destroyed !'}
    else
      render json: {message: @friendship.errors.messages}
    end
  end

  def destroyMutualFriendship
  
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts params
    
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
 
  end




  private
def friendship_params
  params.require(:friendship).permit(:friend_id, :user_id, :avatar_link)
end
end
