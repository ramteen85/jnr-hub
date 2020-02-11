class ApplicationController < ActionController::Base
  before_action :allow_cors
  # skip_before_action :verify_authenticity_token

  # skip_before_action :verify_authenticity_token

  # Redirects user to login path if the user is neither an employer, or an admin
  def check_if_employer
    redirect_to login_path unless @current_user.present? && @current_user.user_type == "employer" || @current_user.admin?
  end
  def allow_cors
    headers['Access-Control-Allow-Origin'] = '*'
  end



  # JSON Web Tokens
  def encode_token(payload={})
    exp = 24.hours.from_now
    payload[:exp] = exp.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
  end
  def decode_token(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base, true, { algorithm: 'HS256' })
  end
end
