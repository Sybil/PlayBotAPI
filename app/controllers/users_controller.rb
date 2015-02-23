class UsersController < ApplicationController

  def index
    @users = User.all.order(quantity: :desc)
    render json: @users, status: 200
  end

end
