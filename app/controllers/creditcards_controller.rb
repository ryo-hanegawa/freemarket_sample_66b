class CreditcardsController < ApplicationController
  
  require "payjp"

  def index
  end

  def new
    card = Creditcard.where(user_id: current_user.id)
    redirect_to action: "show" if card.exists?
  end

  def pay
    binding.pry
    Payjp.api_key = Rails.application.credentials[:payjp_private_key]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        # description: "カード登録",
        # email: current_user.email,
        card: params['payjp-token'],
        # metadata: { user_id: current_user.id }
      )
      # binding.pry
      @card = Creditcard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "create"
      end
    end
  end

  def show
    card = Creditcard.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = Rails.application.credentials[:payjp_private_key]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
      @exp_month = @default_card_information.exp_month.to_s
      @exp_year = @default_card_information.exp_year.to_s.slice(2,3)
    end
  end

  def delete
    card = Creditcard.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = Rails.application.credentials[:payjp_private_key]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
    redirect_to action: "new"
  end

  def confirmation
    card = current_user.credit_cards
    redirect_to action: "show" if card.exists?
  end
end
