class CreditcardsController < ApplicationController
  # def index
  # end

  def new
    
  end

  def create
    redirect_to controller: '/signup', action: 'done'
  end

  # def destroy
  # end
end
