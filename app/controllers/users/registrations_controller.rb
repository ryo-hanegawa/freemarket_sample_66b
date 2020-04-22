class Users::RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    addresses_new_path
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    addresses_new_path
  end

  def step1
    @user = User.new
  end
  
  def step2
    session[:nickname] = params[:user][:nickname]
    session[:email] = params[:user][:email]
    session[:password] = params[:user][:password]
    session[:password_confirmation] = params[:user][:password_confirmation]
    session[:f_name_kana] = params[:user][:f_name_kana]
    session[:l_name_kana] = params[:user][:l_name_kana]
    session[:f_name_kanji] = params[:user][:f_name_kanji]
    session[:l_name_kanji] = params[:user][:l_name_kanji]
    session[:birthday] = birthday_join
    @user = User.create(nickname:session[:nickname], email: session[:email], password: session[:password], password_confirmation: session[:password_confirmation], f_name_kana: session[:f_name_kana],l_name_kana: session[:l_name_kana], f_name_kanji: session[:f_name_kanji], l_name_kanji: session[:l_name_kanji], birthday: session[:birthday], tel: params[:user][:tel])
  end



  def create
    if params[:user][:password].nil?
      @user = User.create(nickname:session[:nickname], email: session[:email], password: session[:password], password_confirmation: session[:password_confirmation], f_name_kana: session[:f_name_kana],l_name_kana: session[:l_name_kana], f_name_kanji: session[:f_name_kanji], l_name_kanji: session[:l_name_kanji], birthday: session[:birthday], tel: params[:user][:tel])
      sns = SnsCredential.create(user_id: @user.id,uid: params[:user][:uid], provider: params[:user][:provider])
      sign_in(@user)
      redirect_to controller: '/addresses', action: 'step3'
    else 
      redirect_to :back
    end
  end

  private
  def user_via_sns_params
    password = Devise.friendly_token.first(7)
    params.require(:user).permit(:nickname, :email, :f_name_kanji, :l_name_kanji, :f_name_kana, :l_name_kana, :birthday, :tel, :uid, :provider).merge(password: password, password_confirmation: password)
  end



  def birthday_join
    year = params[:user]["birthday(1i)"]
    month = params[:user]["birthday(2i)"]
    day = params[:user]["birthday(3i)"]
    birthday = year.to_s + "-" + month.to_s + "-" + day.to_s
    return birthday
  end

end