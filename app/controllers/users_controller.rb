class UsersController < ApplicationController
  before_action :allow_cors
  skip_before_action :verify_authenticity_token
  # before_action :authenticate_user, only: [ :show, :getUser, :profile, :update ] # require tokens

  def home
  end

  def jobapplicants

    # grab params
    token = params['token']
    job_id = params['job_id']

    # Check Token
    begin
      decoded = decode_token(token)
      check_user = User.find_by(email: decoded[0]['email'])

    rescue StandardError => e
      render json: {
        "error": "Invalid Token"
      }
    end

    # Users who applied for the job
    job = Job.where(id: job_id).first

    # initialize final array and loop
    applicants = []
    i = 0

    # find all applications matching user id
    applications = Application.where(id: job.id)

    # For each application, grab user info and stash in array
    loop do
      if i == job.applications.length
        break
      end

      # find extract and remap data
      tmp = job.applications[i].user_id
      tmp2 = User.find(tmp)
      tmpDto = {
        name: tmp2.full_name,
        phone_no: tmp2.phone_no,
        email: tmp2.email
      }

      # push each applicant user info into array
      applicants.push(tmpDto)

      i += 1
    end

    # return the user array
    render json: applicants
  end


  def new
    @user = User.new
  end

  def profile
    token = params['token']

    begin
      decoded = decode_token(token)
      user = User.find_by(email: decoded[0]['email'])
      render json: user, :include => [:jobs, :jobs_applied_for]
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
