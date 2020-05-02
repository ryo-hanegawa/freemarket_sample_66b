class TopController < ApplicationController
  def index
    # N+1問題を解消し、itemsテーブルの指定のレコードを@itemsに代入
    @items = Item.select(:id, :name, :price).includes(:images).order(:id[ASC])
  end
end
