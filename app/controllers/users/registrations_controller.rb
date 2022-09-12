class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success

    3.times do |i|
      random_user = User.find_by_id(rand(1..50))
      i = Invitation.new(
        sender_id: random_user.id,
        receiver_id: User.last.id
      )
      i.save
    end
 

  
    render json: { message: 'Signed up sucessfully.' }
  end

  def register_failed
    render json: { message: "Something went wrong." }
  end
end