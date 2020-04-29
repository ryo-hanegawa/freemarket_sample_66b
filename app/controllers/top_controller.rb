class TopController < ApplicationController
  def index
    # N+1問題を解消し、itemsテーブルの全てのレコードを@itemsに代入
    @items = Item.all.includes(:images)
  end
end
