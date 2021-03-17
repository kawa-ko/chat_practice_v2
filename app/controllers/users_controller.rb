class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @rooms = @user.created_rooms.all.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      UserMailer.account_activation(@user).deliver_now
      redirect_to root_path
      flash[:success] = 'アカウントを有効化するために登録したメールアドレスをご確認ください。'
    else
      flash.now[:false] = 'ユーザー登録に失敗しました'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_url
      flash[:success] = 'ユーザー情報を更新しました'
    else
      render :new
      flash[:false] = 'ユーザー編集に失敗しました'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to root_url
      flash[:success] = '退会しました'
    else
      redirect_back
      flash[:false] = '退会に失敗しました'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :remove_image, :prof)
  end

end
