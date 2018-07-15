class ApplicationController < ActionController::Base

def check_session
    user_id = session[:user_id]
    if(user_id)
        @current_user = User.find_by_id(user_id)
        if(@current_user)
            return true
        end
    end
    redirect_to(:controller => 'account', :action => 'login')
    return false
end

def save_login_state
    user_id = session[:user_id]
    if(user_id)
        redirect_to(:controller => 'profiles', :action => 'all')
        return false
    end
    return true
end

end
