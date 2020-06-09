class Api::UsersController < Api::ApplicationController
  before_action :users, only: :index

  def index
    render json: @users, status: 200
  end

  private
  def users
    @users = User.all
  end
end