class UsersController < ApplicationController
  #Certain pages not visible if you arent logged in
  # before_action :check_if_logged_in, except: [ :new, :create ]
  before_action :check_if_admin, only: [ :index, :destroy ]
  before_action :allow_cors
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user, only: [ :show, :getUser, :profile, :update ] # require tokens

  # Lock down admin pages
  # before_action :check_if_admin, only: [ :index ]
  def home
  end

  def new
    @user = User.new
  end

  def profile
    render json: current_user, include: :jobs

  end

  def getUser
    @user = User.find_by(email: params['user'])
    render json: { message: "ok", user_id: @user.id, user_type: @user.user_type }
  end

  def create

    @user = User.create user_params

    if @user.persisted?
      session[:user_id] = @user.id
      render json: { message: "ok", user_id: @user.id, user_type: @user.user_type }
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

    # update whichever field(s) was sent through from the React frontend
    if current_user.update( user_params )
      render json: { user: current_user }
    else
      render json: { error: current_user.errors.full_messages }
    end



    # artist = Artist.find params[:id]
        # artist.update artist_params   # also use the strong params for the update

        # redirect_to user_path(user.id)





    # redirect_to planet_path(user.id)


  end

  def destroy
    @user = User.find(params[:id])
    if @user.present?
      @user.destroy
    end
    redirect_to '/users'
  end
  #
  # def register
  #     respond_to do |format|
  #     format.json { render text: t.response }
  #   end
  # end

  private
  def user_params
    params.require(:user).permit( :full_name, :email, :password, :password_confirmation, :phone_no, :suburb, :country, :state, :website, :about, :user_type )
  end

end
