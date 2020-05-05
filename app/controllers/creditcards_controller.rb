class CreditcardsController < ApplicationController
  require "payjp"
  # def index
  # end

  def new
    card = Creditcard.where(user_id: current_user.id)
    redirect_to action "show" if card.exist?
  end

  def create
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action "new"
    else
      customer = Payjp::Customer.create(
        description: "カード登録",
        email: current_user.email,
        card: params['payjp-token'],
        metadata: { user_id: current_user.id }
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "create"
      end
    end
  end

  # def destroy
  # end
end
