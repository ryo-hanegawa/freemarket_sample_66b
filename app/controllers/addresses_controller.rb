class AddressesController < ApplicationController
  def step3
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to controller: '/creditcards', action: 'new'
    else
      redirect_to controller: '/addresses', action: 'step3'
    end
    
  end

    private
    def address_params
      params.require(:address).permit(:last_name, :first_name, :last_name_reading, :first_name_reading, :postal_code, :city, :prefecture_id, :street, :building)
    end
end