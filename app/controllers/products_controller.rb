class ProductsController < ApplicationController
  def index
  end

  def edit
    @item = Item.find(params[:id])
  end

  def show
    @item = Item.find(params[:id])
    @images = @item.images
    @image = @images.first
    end


  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to item_path(item.id)
  end

  def destroy
  end
end
