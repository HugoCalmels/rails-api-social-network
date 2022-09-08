class Api::V1::InvitationsController < ApplicationController
  before_action :set_invitation, only: [:show, :update, :destroy]

  # GET /invitations
  def index

    @invitations = Invitation.all.select do |invit, i|
    invit.receiver_id == current_user.id  
    end

    render json: @invitations , include: [:sender]
  end

  # GET /invitations/1
  def show
    render json: @invitation
  end

  # POST /invitations
  def create
    @invitation = Invitation.new(invitation_params)

    if @invitation.save
      render json: @invitation, include: [:sender]
    else
      render json: @invitation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /invitations/1
  def update
    @invitation = Invitation.all.find_by_id(params[:id])
    @invitation.seen = true
    @invitation.save
    @invitation.seen = params[:invitation][:seen]
    render json: @invitation, include: [:sender]

    #if @invitation.update(invitation_params)
    #  render json: @invitation
    #else
    #  render json: @invitation.errors, status: :unprocessable_entity
    #end
  end

  # DELETE /invitations/1
  def destroy
    @invitation.destroy

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitation
      @invitation = Invitation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def invitation_params
      params.require(:invitation).permit(:sender_id, :receiver_id, :confirmed, :seen)
    end
end
