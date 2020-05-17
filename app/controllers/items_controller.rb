class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :set_items, only: [:show, :edit, :update, :destroy]

  def index
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
      @parents = Category.where(ancestry: nil)
      @item.images.new  # 再度、itemにひもづくimageをオブジェクトを生成
      render :new
    end
  end

  def edit
    @item.images.cache_key unless @item.images.blank?
    @parents = Category.where(ancestry: nil)
    @parent_category = @item.category.root
    @child = @parent_category.children
    @child_category = @item.category.parent
    @grandchild = @child_category.children
    @grandchild_category = @item.category
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
    redirect_to controller: :items, action: :delete_done if @item.user_id == current_user.id && @item.destroy
  end

  def delete_done
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
    params.require(:item).permit(:name, :description, :size, :category_id, :condition, :brand, :postage, :prefecture, :deliberydate, :price, :buyer, images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end

  # def item_update_params
  #   params.require(:item).permit(:name, :description, :size, :category_id, :condition, :brand, :postage, :prefecture, :deliberydate, :price, :buyer, images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  # end

  def set_items
    @item = Item.find(params[:id])
  end
  



# before_action :authenticate_user!, only:[:edit, :update, :destroy]
# before_action :set_item, only: [:edit, :show, :update, :destroy]

  # def index
  # end

  # def edit
  #   @item.images.cache_key unless @item.images.blank?

  #   @grandchild_category = @item.category
  #   @child_category = @item.category.parent
  #   @parent_category = @item.category.root

  #   @parents = Category.where(ancestry: nil)
  #   @child = @parent_category.children
  #   @grandchild = @child_category.children

  # end

  # def show
  #   @images = @item.images
  #   @image = @images.first
    
  #   @grandchild_category = @item.category
  #   @child_category = @item.category.parent
  #   @parent_category = @item.category.root

  #   if @image == nil
  #     redirect_to action: 'index'
  #   end
  # end

  # def update
  #   @item.update(item_params)
  #   if @item.save
  #     redirect_to action: 'show'
  #     else
  #       @items == nil
  #       redirect_to(edit_item_path, notice: '編集できませんでした')
  #   end
  # end

  # def destroy
  #   @item.destroy if @item.user_id == current_user.id
  #   redirect_to controller: :products, action: :index if @item.user_id == current_user.id && @item.destroy
  # end

  # def search_edit
  #   respond_to do |format|
  #     format.html
  #     format.json do
  #       # 親ボックスのidから子ボックスのidの配列を作成してインスタンス変数で定義
  #       @children = Category.find(params[:parent_id]).children
  #     end
  #   end
  # end

  # def grandchildren_edit
  #   respond_to do |format|
  #     format.html
  #     format.json do
  #       # 子ボックスのidから孫ボックスのidの配列を作成してインスタンス変数で定義
  #       @grandchildren = Category.find(params[:child_id]).children
  #     end
  #   end
  # end

  # private
  # def item_update_params
  #   params.require(:item).permit(:name, :description, :size, :category_id, :condition, :brand, :postage, :prefecture, :deliberydate, :price, :buyer, images_attributes: [:image]).merge(user_id: current_user.id)
  # end

  # def set_item
  #   @item = Item.find(params[:id])
  # end

end
