class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})

  
      if User.all.find_by(email:resource.email)

        if resource.id.present?
          render json: { message: 'You are logged in.' }, status: :ok
        else 
          render json: {
          error: "wrong password",
          status: 401
        }, status: 401
        end
      else
        render json: {
          error: "wrong account",
          status: 400
        }, status: 400
 
      end


  end

  

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failure
  end

  def log_out_success
    render json: { message: "You are logged out." }, status: :ok
  end

 
end