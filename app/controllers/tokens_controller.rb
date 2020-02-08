class TokensController < ApplicationController
  before_action :allow_cors
  skip_before_action :verify_authenticity_token
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      render json: {
        jwt: encode_token({id: user.id, email: user.email, userType: user.user_type})
      }
    else
      head :not_found
    end

  end
end
