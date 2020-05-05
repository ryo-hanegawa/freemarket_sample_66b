class TopController < ApplicationController
  def index # viewファイルに持っていくインスタンス変数を作成
    # N+1問題を解消し、itemsテーブルの指定のレコードを@itemsに代入
    @items = Item.select(:id, :name, :price).includes(:images).order("id DESC")
  end
end
