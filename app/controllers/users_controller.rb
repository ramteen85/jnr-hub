class UsersController < ApplicationController
  #Certain pages not visible if you arent logged in
  before_action :check_if_logged_in, except: [ :new, :create ]
  before_action :check_if_admin, only: [ :index, :destroy]


  # Lock down admin pages
  # before_action :check_if_admin, only: [ :index ]
  def home
  end
  def new
    @user = User.new
  end

  def create

    @user = User.create user_params

    if @user.persisted?
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end

  end

  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
  end

  def edit
  end

  def update
  end

  def destroy
    @user = User.find(params[:id])
    if @user.present?
      @user.destroy
    end
    redirect_to '/users'
  end

  def register
      respond_to do |format|
      format.json { render text: t.response }
    end
  end

  private
  def user_params
    params.require(:user).permit( :full_name, :email, :password, :password_confirmation, :admin, :phone_no, :suburb, :country, :state, :website, :about, :admin )
  end

end
