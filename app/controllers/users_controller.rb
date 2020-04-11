class UsersController < ApplicationController
  def index
  end

  def signup
  def show
    @user = User.find(params[:id])

  end
end
