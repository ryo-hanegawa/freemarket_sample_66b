class ProductsController < ApplicationController
  def index
  end

  def edit
    @user = User.find(params[:nickname])
    @item = Item.find(params[:id])
  end

  def show
    # @user = User.find(params[:id])
    @item = Item.find(params[:id])
    @images = @item.images
    @image = @images.first
    end


  def update
    @user = User.find(params[:nickname])
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to item_path(item.id)
  end

  def destroy
  end
end
