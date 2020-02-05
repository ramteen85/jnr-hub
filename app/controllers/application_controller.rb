class ApplicationController < ActionController::Base

  before_action :fetch_user
  include Knock::Authenticable

  def fetch_user

    if session[:user_id].present?
      @current_user = User.find_by id: session[:user_id]
    end

    unless @current_user.present?
      session[:user_id] = nil
    end
  end

  def check_if_logged_in
    redirect_to login_path unless @current_user.present?
  end

  def check_if_admin
    redirect_to login_path unless @current_user.present? && @current_user.admin?
  end

  def check_if_employer
    redirect_to login_path unless @current_user.present? && @current_user.user_type == "employer" || @current_user.admin?
  end
  def allow_cors
  headers['Access-Control-Allow-Origin'] = '*'
end
end
