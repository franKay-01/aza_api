
require "utilities"

class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    util = Utilities::Util.new

    @user.uuid = util.get_random_uuid

    if @user.save
      render json: @user.as_json(only: [:email]), status: :ok
    else
      render json: 'Failed'
    end
  end


  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
