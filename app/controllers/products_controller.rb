class ProductsController < ApplicationController
before_action :authenticate_user!, only:[:edit, :show, :update, :destroy]
before_action :set_item, only: [:edit, :show, :update, :destroy]

  def index
  end

  def edit
    @item.images.cache_key unless @item.images.blank?

    @grandchild_category = @item.category
    @child_category = @item.category.parent
    @parent_category = @item.category.root

    @parents = Category.where(ancestry: nil)
    @child = @parent_category.children
    @grandchild = @child_category.children

  end

  def show
    @card = Creditcard.where(user_id: current_user.id)
    @images = @item.images
    @image = @images.first
    
    @grandchild_category = @item.category
    @child_category = @item.category.parent
    @parent_category = @item.category.root

    if @image == nil
      redirect_to action: 'index'
    end
  end

  def update
    @item.update(item_params)
    if @item.save
      redirect_to action: 'show'
      else
        @items == nil
        redirect_to(edit_item_path, notice: '編集できませんでした')
    end
  end

  def destroy
    @item.destroy if @item.user_id == current_user.id
    redirect_to controller: :products, action: :index if @item.user_id == current_user.id && @item.destroy
  end

  def search_edit
    respond_to do |format|
      format.html
      format.json do
        # 親ボックスのidから子ボックスのidの配列を作成してインスタンス変数で定義
        @children = Category.find(params[:parent_id]).children
      end
    end
  end

  def grandchildren_edit
    respond_to do |format|
      format.html
      format.json do
        # 子ボックスのidから孫ボックスのidの配列を作成してインスタンス変数で定義
        @grandchildren = Category.find(params[:child_id]).children
      end
    end
  end

  private
  def item_update_params
    params.require(:item).permit(:name, :description, :size, :category_id, :condition, :brand, :postage, :prefecture, :deliberydate, :price, :buyer, images_attributes: [:image]).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end