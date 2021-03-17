class AccountActivationsController < ApplicationController
    def edit
        user = User.find_by(email: params[:email])
        if user && !user.activated? && user.authenticated?(:activation, params[:id])
            user.update_attribute(:activated, true)
            user.update_attribute(:activated_at, Time.zone.now)
            login(user, user.password)
            flash[:success] = "アカウントが有効化されました。"
            redirect_to user
        else
            flash[:danger] = "アカウントの有効化に失敗しました"
            redirect_to root_path
        end
    end
end
