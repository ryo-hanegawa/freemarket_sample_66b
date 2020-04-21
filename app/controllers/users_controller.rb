class UsersController < ApplicationController
  def after_sign_up_path_for(resource)
    addresses_new_path
  end

  def after_inactive_sign_up_path_for(resource)
    addresses_new_path
  end

  def show
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
      session[:first_name_reading] = params[:user][:first_name_reading]
      session[:last_name_reading] = params[:user][:last_name_reading]
      session[:f_name] = params[:user][:first_name]
      session[:l_name] = params[:user][:last_name]
      session[:birthday] = birthday_join
      session[:provider] = session[:provider]
      session[:uid] = session[:uid]
      @user = User.create(nickname:session[:nickname], email: session[:email], password: session[:password], password_confirmation: session[:password_confirmation], first_name_reading: session[:first_name_reading],last_name_reading: session[:last_name_reading], first_name: session[:first_name], last_name: session[:last_name], birthday: session[:birthday], tel: params[:user][:tel])
    end
  end



  def create
      @user = User.create(nickname:session[:nickname], email: session[:email], password: session[:password], password_confirmation: session[:password_confirmation], first_name_reading: session[:first_name_reading],last_name_reading: session[:last_name_reading], first_name: session[:first_name], last_name: session[:last_name], birthday: session[:birthday], tel: params[:user][:tel])
    end

  #   if @user.save
  #     redirect_to controller: '/addresses', action: 'step3'
  #     sign_in(@user)
  #     bypass_sign_in(@user)
  #   else
  #     render "step1"
      
  #   end
  # end

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