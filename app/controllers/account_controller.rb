class AccountController < ApplicationController

layout :define_layout

before_action :check_session , :only => [:home]
before_action :save_login_state , :only => [:login, :login_attempt]


def register
    @account = Account.new
end

def create
    @account = Account.new
    @account.init_account(user_param)
    @account.save

    user = User.new
    user.init_user(user_param, @account.id)
    if user.save
        flash[:notice] = "You signed up successfully"
        flash[:color]= "valid"
        render "login"
    else
        @account.delete
        flash[:notice] = "Form is invalid"
        flash[:color]= "invalid"
        render "register"
    end
end

def user_param
    params.require(:account).permit(:username, :email, :password, :password_confirmation, :phone, :business_name, :account_name)
end

def login
end

def home
end

def login_attempt
  authenticated_user = User.authenticate(params[:username_or_email], params[:login_password])
  if(authenticated_user)
    session[:user_id] = authenticated_user.id
    flash[:notice] = "You Logged in successfully"
    redirect_to(:controller => 'profiles', :action => 'all')
  else
    flash[:notice] = "Invalid details"
    redirect_to(:action => 'login')
  end
end

def logout
    session[:user_id] = nil
    redirect_to(:action => 'login')
end

private
def define_layout
    if(@current_user)
        return "application"
    else
        return "custom_login"
    end
end

end
