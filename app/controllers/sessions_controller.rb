class SessionsController < ApplicationController

  def create
    user = User.find_by_email(session_params[:email])
    if user.authentic?(session_params[:password])
      render json: user.obtain_api_key.refresh!, status: 200
    else
      render json: "Wrong password", status: 401
    end
  end

  def session_params
    params[:session].permit(:email, :password)
  end

end
