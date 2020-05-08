class ProductsController < ApplicationController

before_action :set_user, only: [:edit, :show, :update]
before_action :set_item, only: [:edit, :show, :update]

  def index
  end

  def edit
  end

  def show
    @images = @item.images
    @image = @images.first
    end


  def update
    item.update(item_params)
    redirect_to item_path(item.id)
  end

  def destroy
  end

private
  def set_user
    @user = User.find(params[:id])
  end

  def set_item
    @item = Item.find(params[:id])
end
end