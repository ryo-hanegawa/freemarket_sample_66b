class UsersController < ApplicationController
  def index
  end

  def signup
  end
  def show
    @user = User.find(params[:id])
  end