class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_items, except: [:index, :new, :create, :search, :grandchildren]
  before_action :item_update_params,             only:[:update]
  before_action :set_user, only: [:edit, :show, :update, :destroy]
  def index
    @items = Item.includes(:images)
  end

  def new
    @item = Item.new
    @items = Item.includes(:images, :images_attributes)
    @item.images.new
    @parents = Category.where(ancestry: nil)
  end

  def show
    @images = @item.images
    @image = @images.first
    
    @grandchild_category = @item.category
    @child_category = @item.category.parent
    @parent_category = @item.category.root

    if @image == nil
      redirect_to action: 'index'
    end
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
    @item.images.cache_key unless @item.images.blank?

    @parents = Category.where(ancestry: nil)
    @grandchild_category = @item.category
    @child_category = @item.category.parent
    @parent_category = @item.category.root
  end

  def update
    if params[:item][:images_attributes] == nil && @item.update(item_update_params)
      redirect_to controller: :products, action: 'show'
    else
      @item.images.destroy
      if @item.update(item_update_params)
        redirect_to controller: :products, action: 'show'
      else
        @images == nil
        redirect_to(edit_product_path, notice: '編集できませんでした')
      end
    end
  end

  def destroy
    @item.destroy if @item.user_id == current_user.id
    redirect_to controller: :products, action: :index if @item.user_id == current_user.id && @item.destroy
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

  def set_user
    @user = User.find(current_user.id)
  end

  def item_params
    params.require(:item).permit(:name, :description, :size, :category_id, :condition, :brand, :postage, :prefecture, :deliberydate, :price, :buyer, images_attributes: [:image]).merge(user_id: current_user.id)
  end

  def item_update_params
    params.require(:item).permit(:name, :description, :size, :category_id, :condition, :brand, :postage, :prefecture, :deliberydate, :price, :buyer, images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def create_items_instance
    @item = Item.new
  end

  def set_items
    @item = Item.find(params[:id])
  end
end
