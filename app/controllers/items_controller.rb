class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_items, only: [:index, :new, :create, :edit, :update]
  def index
    @items = Item.includes(:images)
  end

  def new
    @item = Item.new
    @items = Item.includes(:images, :images_attributes)
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
    @item = Item.find(params[:id])
    # @images = @item.images.order(id: "DESC")
  end


  def update
    if params[:item][:images_attributes] == nil
      @item.update(item_update_params)
      redirect_to action: 'show'
    else
      @item.images.destroy_all
      if @item.update(item_params)
        redirect_to action: 'show'
      else
        redirect_to(edit_product_path, notice: '編集できませんでした')
      end
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :size, :category, :condition, :brand, :postage, :prefecture, :deliberydate, :price, :buyer, images_attributes: [:image])
  end

  def item_update_params
    params.require(:item).permit(:name, :description, :size, :category, :condition, :brand, :postage, :prefecture, :deliberydate, :price, :buyer, images_attributes: [:image])
  end

  def create_items_instance
    @item = Item.new
  end

  def set_items
    @item = Item.find(params[:id])
  end
end
