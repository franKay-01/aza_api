require 'json_web_token'

class ApplicationController < ActionController::API

  def authorize_request
    web_token = JsonWebToken::WebToken::new

    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin

      @decoded = web_token.decode(header)
      @current_user = User.where(uuid: @decoded['user_id']).first

    rescue ActiveRecord::RecordNotFound => e
      render json: { resp_code: ERROR, errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { resp_code: ERROR, errors: e.message }, status: :unauthorized
    end
  end
  
end
