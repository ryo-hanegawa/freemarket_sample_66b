class PurchasesController < ApplicationController
  require "payjp"
  before_action :set_card, only: [:show, :pay]

  def show
    # card = Card.where(user_id: current_user.id).first
    # Cardテーブルは前回記事で作成、テーブルからpayjpの顧客IDを検索
    if @card.first.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to new_user_creditcard_path(user_id: current_user.id)
    else
      Payjp.api_key = Rails.application.credentials[:payjp_private_key]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@card.first.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@card.first.card_id)
    end
  end

  def pay
    # card = Card.where(user_id: current_user.id).first
    Payjp.api_key = Rails.application.credentials[:payjp_private_key]
    Payjp::Charge.create(
      :amount => 13500, #支払金額を入力（itemテーブル等に紐づけても良い）
      :customer => @card.customer_id, #顧客ID
      :currency => 'jpy', #日本円
    )
    redirect_to action: 'done' #完了画面に移動
  end

  private
  def set_card
    @card = Creditcard.where(user_id: current_user.id)
  end
end
