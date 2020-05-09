class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, except: [:index, :new, :create]
  def index
    @items = Item.includes(:images)
  end

  def new
    @item = Item.new
    @items = Item.includes(:images, :images_attributes)
    @item.images.new
    @parents = Category.where(ancestry: nil)
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
  end


  def update

  end

  def search
    respond_to do |format|
      format.html
      format.json do
        # 親ボックスのidから子ボックスのidの配列を作成してインスタンス変数で定義
        @children = Category.find(params[:parent_id]).children
      end
    end
  end

  def grandchildren
    respond_to do |format|
      format.html
      format.json do
        # 子ボックスのidから孫ボックスのidの配列を作成してインスタンス変数で定義
        @grandchildren = Category.find(params[:child_id]).children
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
