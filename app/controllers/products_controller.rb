class ProductsController < ApplicationController

before_action :authenticate_user!,       only:[:new,:create,:destroy,:edit,:update]
before_action :set_user, only: [:edit, :show, :update, :destroy]
before_action :set_item, only: [:edit, :show, :update, :destroy]

  def index
  end

  def edit
    @item.images.cache_key unless @item.images.blank?
  end

  def show
    @images = @item.images
    @image = @images.first
    
    @grandchild_category = @item.category
    @child_category = @item.category.parent
    @parent_category = @item.category.root
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
        redirect_to(edit_item_path, notice: '編集できませんでした')
      end
    end
  end

  def destroy
    @item.destroy if @item.user_id == current_user.id
    redirect_to controller: :products, action: :index if @item.user_id == current_user.id && @item.destroy
  end

private
  def set_user
    @user = User.find(current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
end
end