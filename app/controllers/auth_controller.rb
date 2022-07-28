require "json_web_token"

class AuthController < ApplicationController

  def create
    web_token = JsonWebToken::WebToken::new

    user = User.where(email: user_params[:email]).first

    if user&.valid_password?(user_params[:password])
      token = web_token.encode(user_id: user.uuid)
      
      render json: {resp_code: SUCCESS, data: {token: token, username: user.as_json(only: [:email])}}, status: :created
    else
      render json: {resp_code: ERROR, error: 'Unauthorized'}
    end
  end

  def signout

  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end