class ApplicationController < ActionController::Base
  include Knock::Authenticable

  # Redirects user to login path if the user is neither an employer, or an admin
  def check_if_employer
    redirect_to login_path unless @current_user.present? && @current_user.user_type == "employer" || @current_user.admin?
  end
  def allow_cors
  headers['Access-Control-Allow-Origin'] = '*'
end
end
