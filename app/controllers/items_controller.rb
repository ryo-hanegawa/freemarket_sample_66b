class ItemsController < ApplicationController
  before_action :authenticate_user!
  def index
    @items = Item.includes(:images)
  end

  def new
    @item = Item.new
    @items = Item.includes(:images)
    @item.images.new
  end

  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to controller: :items, action: :index
    else 
      redirect_to new_item_path
    end
  end

  def edit
  end

  before_action :set_item, except: [:index, :new, :create]

  def update

  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :size, :category, :condition, :brand, :postage, :prefecture, :deliberydate, :price, :buyer, images_attributes: [:image])
  end

  def item_update_params
    params.require(:item).permit(:name, :description, :size, :category, :condition, :brand, :postage, :prefecture, :deliberydate, :price, :buyer)
  end

  def create_items_instance
    @item = Item.new
  end

  def set_items
    @item = Item.find(params[:id])
  end
end
