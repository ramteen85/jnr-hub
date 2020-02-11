class ApplicationsController < ApplicationController

  skip_before_action :verify_authenticity_token


  # delete all applications (for cleanup)
  def delete

    render json: { message: "this is not needed right now" }

    # @applications = Application.destroy_all
    # if @applications.present?
    #   puts "deleting..."
    #   render json: { message: "ok" }
    # else
    #   render json: { message: "nothing to delete" }
    # end
    
  end


  def create

    token = params['token']

    # Check Token
    begin
      decoded = decode_token(token)
      check_user = User.find_by(email: decoded[0]['email'])

    rescue StandardError => e
      render json: {
        "error": "Invalid Token"
      }
    end

    @currentapplication = Application.where(job_id: params['job_id'], user_id: params['user_id'])
    # add application to database if it does not exist
    if @currentapplication.length != 1

      # increment job applicants
      job = Job.find_by(id: params['job_id'])
      job['applicants'] += 1
      job.save

      app = Application.create(
        job_id: params[:job_id],
        user_id: decoded[0]['id']
      )
    end

    render json: app
  end

end
