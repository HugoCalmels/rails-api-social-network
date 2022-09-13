class Api::V1::SuggestionsController < ApplicationController
  before_action :set_suggestion, only: [:show, :update, :destroy]

  # GET /suggestions
  def index

    data = []
    current_user_list_of_friends_ids = current_user.friends.map {|el|el.id}

    current_user.friends.map do |friend|

      friend.friends.filter do |el|
        # name : test
        if el.id != current_user.id &&  current_user_list_of_friends_ids.exclude?(el.id)
        res = el.friends.filter do |el2|
          # friends from test that I also have
          el2.id != current_user.id &&  current_user_list_of_friends_ids.include?(el2.id)
        end
        guy = {owner_id: el.id, owner_username: el.username, owner_avatar_link: el.avatar_link}
        guy[:users] = res
        data.push(guy)
      end
      end

    end
    test2222 = data.uniq 
    (9-test2222.length).times do|i|
      u = User.all.find_by_id(rand(1..50))
      guy = {owner_id: u.id, owner_username: u.username, owner_avatar_link: u.avatar_link}
      guy[:users] = []
      test2222.push(guy)
    end
    render json: test2222.uniq
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
