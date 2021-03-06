class Users::RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    addresses_new_path
  end

  def after_inactive_sign_up_path_for(resource)
    addresses_new_path
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = { user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @address = @user.build_address
    render :new_address
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(address_params)
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    @user.build_address(@address.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
    redirect_to controller: '/signup', action: 'done'
end

  protected
  def address_params
    params.require(:address).permit(:last_name, :first_name, :last_name_reading, :first_name_reading, :postal_code, :city, :prefecture_id, :street, :building)
  end
end