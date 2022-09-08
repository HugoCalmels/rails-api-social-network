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
    suggestionsUsernames = []

    current_user_friends_list.each do |current_user_friend|
      current_user_friend.friends.each do |some_friend|
        current_user_friends_list.each do |friend|
          test222 = current_user_friend.friends.any? do |el|
            el.username == some_friend.username
          end
          test333 = current_user_friends_list.any? do |el|
            el.username == some_friend.username
          end
          if current_user_friend.id == friend.id && some_friend.id != current_user.id && test222 == true && test333 == false
            suggestion = ''
            foundSuggestion = Suggestion.all.where(owner_id: some_friend.id)
            if Suggestion.exists?(owner_id: some_friend.id)
              suggestion = Suggestion.where(owner: some_friend)
              a = AssoSuggestion.create(user_id: friend.id, suggestion_id: suggestion[0].id)
              
            else 
              suggestion = Suggestion.create(owner: some_friend, owner_username: some_friend.username, owner_avatar_link: some_friend.avatar_link)
              a = AssoSuggestion.create(user_id: friend.id, suggestion_id: suggestion.id)
              suggestionsUsernames.push(some_friend.username)
            end
           
          
          end
        end
      end
    end

  if Suggestion.all.length < 9
    (9-Suggestion.all.length).times do |index| 
      user = User.all.find_by_id(User.all.length - index)
      if user != nil 
        if current_user.friends.any? {|el|el.username == user.username} || suggestionsUsernames.any? {|el|el == user.username} || user.username == current_user.username
        else
  
        suggestion = Suggestion.create(owner: user, owner_username: user.username, owner_avatar_link: user.avatar_link)
        end
      end

    end
  end

  suggestionsData = Suggestion.all.sort_by { |obj| obj.users.length }.reverse

   render json: suggestionsData, include: [:users]
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
