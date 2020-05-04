class Users::RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    addresses_new_path
  end

  # The path used after sign up for inactive accounts.
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

    # binding.pry
    # session[:nickname] = params[:user][:nickname]
    # session[:email] = params[:user][:email]
    # session[:password] = params[:user][:password]
    # session[:password_confirmation] = params[:user][:password_confirmation]
    # session[:first_name_reading] = params[:user][:first_name_reading]
    # session[:last_name_reading] = params[:user][:last_name_reading]
    # session[:first_name] = params[:user][:first_name]
    # session[:last_name] = params[:user][:last_name]
    # session[:birth_year] = params[:user]["birth_day(1i)"]
    # session[:birth_month] = params[:user]["birth_day(2i)"]
    # session[:birth_day] = params[:user]["birth_day(3i)"]
    # @user = User.create(nickname:session[:nickname], email: session[:email], password: session[:password], password_confirmation: session[:password_confirmation], first_name_reading: session[:first_name_reading],last_name_reading: session[:last_name_reading], first_name: session[:first_name], last_name: session[:last_name], birth_year: session[:birth_year], birth_month: session[:birth_month], birth_day: session[:birth_day])
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
    # if params[:user][:password].nil?
    #   binding.pry
    #   @user = User.create(nickname:session[:nickname], email: session[:email], password: session[:password], password_confirmation: session[:password_confirmation], first_name_reading: session[:first_name_reading],last_name_reading: session[:last_name_reading], first_name: session[:first_name], last_name: session[:last_name], birth_year: session[:birth_year], birth_month: session[:birth_month], birth_day: session[:birth_day], phone_number: params[:user][:phone_number])
    #   # @user = User.create(phone_number: params[:user][:phone_number])
    #   # sns = SnsCredential.create(user_id: @user.id,uid: params[:user][:uid], provider: params[:user][:provider])
    #   @user.save
    #   sign_in(:user, @user)
    #   redirect_to controller: '/addresses', action: 'step3'
    # else 
    #   redirect_to :back
    # end
    redirect_to controller: '/signup', action: 'done'
end

  protected
  def address_params
    params.require(:address).permit(:last_name, :first_name, :last_name_reading, :first_name_reading, :postal_code, :city, :prefecture_id, :street, :building) #.merge(user_id: current_user.id)
  end

  # private
  # def user_via_sns_params
  #   password = Devise.friendly_token.first(7)
  #   params.require(:user).permit(:nickname, :email, :first_name, :last_name, :first_name_reading, :last_name_reading, :birth_day, :phone_number, :uid, :provider).merge(password: password, password_confirmation: password)
  # end



  def birthday_join
    year = params[:user]["birth_day(1i)"]
    month = params[:user]["birth_day(2i)"]
    day = params[:user]["birth_day(3i)"]
    birth_day = year.to_s + "-" + month.to_s + "-" + day.to_s
    return birth_day
  end

end