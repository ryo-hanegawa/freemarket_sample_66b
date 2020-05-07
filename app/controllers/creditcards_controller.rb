class CreditcardsController < ApplicationController
  require "payjp"
  before_action :set_card, only: [:new, :show, :delete]

  def new
    redirect_to action: "show" if set_card.exists?
  end

  def pay
    Payjp.api_key = Rails.application.credentials[:payjp_private_key]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        card: params['payjp-token'],
      )
      @card = Creditcard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  def show
    if set_card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = Rails.application.credentials[:payjp_private_key]
      customer = Payjp::Customer.retrieve(set_card.first.customer_id)
      @default_card_information = customer.cards.retrieve(set_card.first.card_id)
      @exp_month = @default_card_information.exp_month.to_s
      @exp_year = @default_card_information.exp_year.to_s.slice(2,3)
    end
  end

  def delete
    if set_card.present?
      Payjp.api_key = Rails.application.credentials[:payjp_private_key]
      customer = Payjp::Customer.retrieve(set_card.first.customer_id)
      customer.delete
      set_card.first.delete
    end
    redirect_to action: "new"
  end

  private
  def set_card
    Creditcard.where(user_id: current_user.id)
  end

end
