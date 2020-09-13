class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    @user = User.find_by(email: email)
    if login(@user,password)
      if params[:session][:remember_me] == '1'
        remember(@user)
      else
        forget(@user)
      end
      flash[:success] = 'ログインに成功しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    forget(current_user)
    session[:user_id] = nil
    redirect_to root_url
  end

  private

  def login(user,password)
    if user && user.authenticate(password)
      session[:user_id] = user.id
      return true
    else
      return false
    end
  end

end
