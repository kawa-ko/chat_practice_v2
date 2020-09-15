class ApplicationController < ActionController::Base
    include SessionsHelper

    private

    def require_user_logged_in?
        unless logged_in?
            respond_to do |format|
                format.html { binding.pry }
                format.js {binding.pry}
            end
        end
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
