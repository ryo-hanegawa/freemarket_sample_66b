class TopController < ApplicationController
  def index # viewファイルに持っていくインスタンス変数を作成
    # itemsテーブルのレコード数を@numに代入
    @num = Item.count
    # N+1問題を解消し、itemsテーブルの指定のレコードを@itemsに代入
    @items = Item.select(:id, :name, :price, :buyer).includes(:images).order("id DESC")
  end
end
