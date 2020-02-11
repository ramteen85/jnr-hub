class ApplicationsController < ApplicationController

  skip_before_action :verify_authenticity_token


  def create
    token = params['token']
    decoded = decode_token(token)
    current_user = User.find_by(email: decoded[0]['email'])
    p current_user

    app = Application.create(
      job_id: params[:job_id],
      user_id: current_user.id
    )

    render json: app
  end

end
