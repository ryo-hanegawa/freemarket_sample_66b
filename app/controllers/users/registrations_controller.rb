class Users::RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    addresses_new_path
  end

  def after_inactive_sign_up_path_for(resource)
    addresses_new_path
  end

  def step1
    @user = User.new
    session[:provider] = session[:provider]
    session[:uid] = session[:uid]
  end
  
  def step2
    #step1で入力した値をsession保持
      session[:nickname] = params[:user][:nickname]
      session[:email] = params[:user][:email]
      session[:password] = params[:user][:password]
      session[:password_confirmation] = params[:user][:password_confirmation]
      session[:f_name_kana] = params[:user][:f_name_kana]
      session[:l_name_kana] = params[:user][:l_name_kana]
      session[:f_name_kanji] = params[:user][:f_name_kanji]
      session[:l_name_kanji] = params[:user][:l_name_kanji]
      session[:birthday] = birthday_join
      session[:provider] = session[:provider]
      session[:uid] = session[:uid]
      @user = User.create(nickname:session[:nickname], email: session[:email], password: session[:password], password_confirmation: session[:password_confirmation], f_name_kana: session[:f_name_kana],l_name_kana: session[:l_name_kana], f_name_kanji: session[:f_name_kanji], l_name_kanji: session[:l_name_kanji], birthday: session[:birthday], tel: params[:user][:tel])
    end



  def create
    if session[:provider].present? && session[:uid].present?#もしoath認証されていたら
      password = Devise.friendly_token.first(7)
      @user = User.create(nickname:session[:nickname], email: session[:email], password: "password", password_confirmation: "password", f_name_kana: session[:f_name_kana],l_name_kana: session[:l_name_kana], f_name_kanji: session[:f_name_kanji], l_name_kanji: session[:l_name_kanji], birthday: session[:birthday], tel: params[:user][:tel])
      sns = SnsCredential.create(user_id: @user.id,uid: session[:uid], provider: session[:provider])
    else#email認証だったら
      @user = User.create(nickname:session[:nickname], email: session[:email], password: session[:password], password_confirmation: session[:password_confirmation], f_name_kana: session[:f_name_kana],l_name_kana: session[:l_name_kana], f_name_kanji: session[:f_name_kanji], l_name_kanji: session[:l_name_kanji], birthday: session[:birthday], tel: params[:user][:tel])
    end

    if @user.save
      redirect_to controller: '/addresses', action: 'step3'
      sign_in(@user)
      bypass_sign_in(@user)
    else
      render "step1"
      
    end
  end
  private


  def birthday_join
    year = params[:user]["birthday(1i)"]
    month = params[:user]["birthday(2i)"]
    day = params[:user]["birthday(3i)"]
    birthday = year.to_s + "-" + month.to_s + "-" + day.to_s
    return birthday
  end

  def customize_sign_up_params
    devise_parameter_sanitizer.permit :sign_up, keys: [:username, :email, :password, :password_confirmation, :remember_me]
  end


end