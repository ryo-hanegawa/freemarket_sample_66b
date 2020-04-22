class AddressesController < ApplicationController
  def step3
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      
    redirect_to controller: '/card', action: 'step4'
    else
    redirect_to controller: '/addresses', action: 'step3'
    end
    
  end

    private
    def address_params
      params.require(:address).permit(:l_name_kanji, :f_name_kanji, :l_name_kana, :f_name_kana, :postal_code, :city, :prefecture, :street, :building).merge(user_id: current_user.id)
    end
end
