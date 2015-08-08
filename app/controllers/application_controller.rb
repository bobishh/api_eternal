class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  protected

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      ApiKey.fresh.exists?(token: token)
    end
  end

end
