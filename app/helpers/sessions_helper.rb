module SessionsHelper
    def remember_login(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    def forget_login(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end
    
    def current_user
        if user_id = session[:user_id]
            if @current_user
                return @current_user
            else
                @current_user = User.find_by(id: user_id)
                return @current_user
            end
        elsif user_id = cookies.signed[:user_id]
            user = User.find_by(id: user_id)
            if user && user.authenticated?(:remember, cookies[:remember_token])
                session[:user_id] = user.id
                @current_user = user
            end
        else
            return false
        end
    end

    def logged_in?
        if current_user
            return true
        else
            return false
        end
    end
end
