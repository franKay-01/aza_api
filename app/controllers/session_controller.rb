class SessionController < ApplicationController
  def create
    user = User.where(email: params[:email]).first

    if user&.valid_password?(params[:password])
      token = JsonWebToken.encode(user_id: @user.uuid)
      render json: {resp_code: Constants::SUCCESS, token: token, username: user.as_json(only: [:email])}, status: :created
    else
      render json: {resp_code: Constants::ERROR ,error: 'Unauthorized'}
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
