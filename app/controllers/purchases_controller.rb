class PurchasesController < ApplicationController
  require "payjp"

  before_action :set_card, :set_item, only: [:show, :pay]
  before_action :set_address, only: :show

  def show
    if @card.first.blank?
      redirect_to new_user_creditcard_path(user_id: current_user.id) 
    else
      Payjp.api_key = Rails.application.credentials[:payjp_private_key]
      customer = Payjp::Customer.retrieve(@card.first.customer_id)
      @default_card_information = customer.cards.retrieve(@card.first.card_id)
      @exp_month = @default_card_information.exp_month.to_s
      @exp_year = @default_card_information.exp_year.to_s.slice(2,3)
      Prefecture.data[@address.prefecture_id][:name]
      @user_address = Prefecture.data[@address.prefecture_id][:name] + @address.city + @address.street + @address.building
      @postal_code = "〒" + @address.postal_code.slice(0..2) + "-" + @address.postal_code.slice(3..6)
    end
  end

  def pay
    Payjp.api_key = Rails.application.credentials[:payjp_private_key]
    Payjp::Charge.create(
      amount: @item.price,
      customer: @card.first.customer_id,
      currency: 'jpy',
    )
    @item.update(item_params)
    redirect_to action: 'done'
  end

  private
  def set_card
    @card = Creditcard.where(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_address
    @address = Address.find(current_user.id)
  end

  def item_params
    params.require(:item).permit(:buyer)
  end
end
