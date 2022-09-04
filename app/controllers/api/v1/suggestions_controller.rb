class Api::V1::SuggestionsController < ApplicationController
  before_action :set_suggestion, only: [:show, :update, :destroy]

  # GET /suggestions
  def index

    Suggestion.all.each do |suggestion|
      suggestion.destroy
    end

    suggestions = []
    current_user_friends_list = current_user.friends
    owners_ids = []
    sTest = ''

    current_user_friends_list.each do |current_user_friend|
      puts "======================================================="
      puts "this hugo friend is "+ current_user_friend.username 
      current_user_friend.friends.each do |some_friend|
        puts "friend # "+some_friend.username
        #here is obviously want only zozo

        current_user_friends_list.each do |friend|
          puts " MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
          test222 = current_user_friend.friends.any? do |el|
            el.username == some_friend.username
          end
          test333 = current_user_friends_list.any? do |el|
            el.username == some_friend.username
          end
          puts test222
          puts " MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
          if current_user_friend.id == friend.id && some_friend.id != current_user.id && test222 == true && test333 == false

            puts "OOOOOOOOOOOOOOOOOOOO"
            puts some_friend.username
            puts "OOOOOOOOOOOOOOOOOOOO"
            suggestion = ''
            foundSuggestion = Suggestion.all.where(owner_id: some_friend.id)

            puts "TEST"
            puts foundSuggestion.nil?
            puts foundSuggestion.empty?
            puts "TEST"

            if Suggestion.exists?(owner_id: some_friend.id)
              suggestion = Suggestion.where(owner: some_friend)
              puts "1111111111111111111"

              puts "FOUND SUGGESTION IS NOT EMPTY"
              puts "THEN WHY I CANNOT ACCES THE OBJECT ??"
              puts "FOUND SUGGESTION IS ABSOLUTELY EMPTY"
   
              #render json: foundSuggestion
              puts "1111111111111111111"
              a = AssoSuggestion.create(user_id: friend.id, suggestion_id: suggestion[0].id)
              
            else 
              #suggestion = foundSuggestion
              puts "2222222222222222"
              puts "FOUND SUGGESTION IS ABSOLUTELY EMPTY"
              #suggestion = Suggestion.create(owner: some_friend, owner_username: some_friend.username, owner_avatar_link: some_friend.avatar_link)
              puts "2222222222222222"
              suggestion = Suggestion.create(owner: some_friend, owner_username: some_friend.username, owner_avatar_link: some_friend.avatar_link)
              a = AssoSuggestion.create(user_id: friend.id, suggestion_id: suggestion.id)
              #a = AssoSuggestion.create(user_id: some_friend.id, suggestion_id: foundSuggestion.id)
            end
           
          
          end
        end
      end
      puts "======================================================="
    end



   #lddd = CommonFriendship.all.where(owner_id: [owners_ids])
   tstt = Suggestion.all
   test555 = Suggestion.all.sort_by { |obj| obj.users.length }.reverse
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

   render json: test555, include: [:users]
  end

  # GET /suggestions/1
  def show
    render json: @suggestion
  end

  # POST /suggestions
  def create
    @suggestion = Suggestion.new(suggestion_params)

    if @suggestion.save
      render json: @suggestion, status: :created, location: @suggestion
    else
      render json: @suggestion.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /suggestions/1
  def update
    if @suggestion.update(suggestion_params)
      render json: @suggestion
    else
      render json: @suggestion.errors, status: :unprocessable_entity
    end
  end

  # DELETE /suggestions/1
  def destroy
    @suggestion.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_suggestion
      @suggestion = Suggestion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def suggestion_params
      params.fetch(:suggestion, {})
    end
end
