class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    @user = User.find_by(email: email)
    if @user.activated?
      if login(@user,password)
        if params[:session][:remember_me] == '1'
          remember_login(@user)
        else
          forget_login(@user)
        end
        flash[:success] = 'ログインに成功しました。'
        redirect_to root_url
      else
        flash.now[:danger] = 'ログインに失敗しました。'
        render :new
      end
    else
      flash[:danger] = 'アカウントが有効化されていません'
      redirect_to root_url
    end
  end

  def destroy
    forget(current_user)
    session[:user_id] = nil
    redirect_to root_url
    flash[:success] = 'ログアウトしました'
  end

  def login(user,password)
    if user && user.authenticate(password)
      session[:user_id] = user.id
      return true
    else
      return false
    end
  end

end
