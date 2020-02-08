class UsersController < ApplicationController
  before_action :allow_cors
  skip_before_action :verify_authenticity_token
  # before_action :authenticate_user, only: [ :show, :getUser, :profile, :update ] # require tokens

  def home
  end

  def new
    @user = User.new
  end

  def profile
    token = params['token']

    puts "Token:"
    puts

    begin
      decoded = decode_token(token)
      user = User.find_by(email: decoded[0]['email'])
      render json: user, include: :jobs
    rescue StandardError => e
      render json: {
        "error": "Invalid Token"
      }
    end 
  end

  def create

    @user = User.create user_params

    if @user.persisted?
      render json: {
        jwt: encode_token({id: @user.id, email: @user.email, userType: @user.user_type})
      }
    else
      render json: { message: "error", errors: @user.errors.full_messages }
    end

  end

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find params[:id]
  end

  def edit
  end

  def update

    token = params['token']
    decoded = decode_token(token)
    current_user = User.find_by(email: decoded[0]['email'])

    # update whichever field(s) was sent through from the React frontend
    if current_user.update( user_params )
      render json: { user: current_user }
    else
      render json: { error: user.errors.full_messages }
    end

  end

  def destroy
    @user = User.find(params[:id])
    if @user.present?
      @user.destroy
    end
    redirect_to '/users'
  end

  private
  def user_params
    params.require(:user).permit( :full_name, :email, :password, :password_confirmation, :phone_no, :suburb, :country, :state, :website, :about, :user_type )
  end
end
