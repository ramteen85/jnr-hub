class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :allow_cors
  skip_before_action :verify_authenticity_token


  def index
    @jobs = Job.all
    render json: @jobs
  end

  def show
    @jobid = params[:id]
    @jobjson = Job.find(@jobid)
    render json: @jobjson
  end

  def new
    @job = Job.new
    check_if_employer
  end

  def edit
  end

  def create

    token = params['token']
    newJob = params['job']

    # check token
    begin
      decoded = decode_token(token)
      user = User.find_by(email: decoded[0]['email'])
    rescue StandardError => e
      render json: {
        message: "error",
        error: "Invalid Token"
      }
    end

    puts newJob



    @job = Job.create!(company_name: newJob['company_name'], location: newJob['location'], description: newJob['description'], salary: newJob['salary'], user_id: user.id, applicants: 0, role: newJob['role'])

    if @job.persisted?
      render json: {
        message: "Job Created Successfully!"
      }
    else
      render json: { message: "error", errors: @user.errors.full_messages }
    end

  end

  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job = Job.find(params[:id])
    if @job.present?
      @job.destroy
    end
    # respond_to do |format|
    #   format.json { head :no_content }
    # end
  end

  private
    def set_job
      @job = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:company_name, :location, :description, :salary)
    end
end
