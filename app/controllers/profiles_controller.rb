class ProfilesController < ApplicationController

before_action :check_session, :only => [:new, :create, :all]

    def new
        @profile=Profile.new
    end

    def create
       profile = Profile.new
       profile.init_profile(params, @current_user.account_id)
       if(profile.save)
            MailSyncJob.perform_later(profile.id)
            flash[:notice] = "Profile created successfully"
            flash[:color]= "valid"
            redirect_to(:action => 'all')
       else
            flash[:notice] = "Profile creation failed"
            flash[:color]= "invalid"
            redirect_to(:action => 'new')
       end
    end

    def all
        account_id = @current_user.account_id
        @profiles=Profile.where('account_id = ?',account_id).select("id, email")
    end
end
