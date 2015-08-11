class SessionsController < ApplicationController

  def create
    user = User.find_by_email(session_params[:email])
    if user && user.authentic?(session_params[:password])
      user.obtain_api_key.refresh!
      render json: user.admin_data.to_json, status: 200
    else
      render json: "Wrong password/email pair", status: 401
    end
  end

  private

  def session_params
    params[:session].permit(:email, :password)
  end

end
