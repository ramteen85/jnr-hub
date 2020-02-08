class SessionController < ApplicationController

  before_action :allow_cors 
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user, only: [ :create ] # require tokens

  def new
    # Action used for user login
  end

  def create
    user = User.find_by email: params[:email]

    if user.present? && user.authenticate( params[:password] )
      # successful login

      session[:user_id] = user.id

      render json: { message: "ok", user_id: user.id, user_type: user.user_type, session_id: session.id.public_id }

    else
    render json: { message: "error", errors: "Invalid username/password" }
  end
end

def destroy
  session[:user_id] = nil # logs out the user
  flash[:notice] = "You have been logged out"
  redirect_to login_path
end
end
