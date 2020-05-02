class ItemsController < ApplicationController
  def index
    @items = Item.includes(:images)
  end

  def new
    @item = Item.new
    @items = Item.includes(:images)
  end

  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to controller: :items, action: :index
    else
      flash.now[:alert] = 'メッセージを入力してください。'
      redirect_to new_item_path
    end
  end

  def edit
  end

  before_action :set_item, except: [:index, :new, :create]

  def update
    @parents = Category.where(ancestry: nil)
    # each do で並べた画像が image
    # 新しくinputに追加された画像が image_attributes
    # この二つがない時はupdateしない
    if params[:item].keys.include?("image") || params[:item].keys.include?("images_attributes") 
      if @item.valid?
        if params[:item].keys.include?("image") 
        # dbにある画像がedit画面で一部削除してるか確認
          update_images_ids = params[:item][:image].values #投稿済み画像 
          before_images_ids = @item.images.ids
          #  商品に紐づく投稿済み画像が、投稿済みにない場合は削除する
          # @product.images.ids.each doで、一つずつimageハッシュにあるか確認。なければdestroy
          before_images_ids.each do |before_img_id|
            Image.find(before_img_id).destroy unless update_image_ids.include?("#{before_img_id}") 

          end
        else
          # imageハッシュがない = 投稿済みの画像をすべてedit画面で消しているので、商品に紐づく投稿済み画像を削除する。
          # @product.images.destroy = nil と削除されないので、each do で一つずつ削除する
          before_images_ids.each do |before_img_id|
            Image.find(before_img_id).destroy 
          end
        end
        @item.update(item_params)
        @size = @item.categories[1].sizes[0]
        @item.update(size: nil) unless @size
        redirect_to item_product_path(@item), notice: "商品を更新しました"
      else
        render 'edit'
      end
    else
      redirect_back(fallback_location: root_path,flash: {success: '画像がありません'})
    end
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
