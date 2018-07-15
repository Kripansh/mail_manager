class MailsController < ApplicationController

before_action :check_session, :only => [:all, :messages]

    def profile
        @profile = Profile.find(params[:id])
        profile_id = @profile.id
        offset = params[:offset].to_i
        limit = 10
        if !offset
            offset = 0
        end
        @total_count = Email.where('profile_id = ?', profile_id).count
        next_value = offset + limit
        prev_value = offset - limit
        if @total_count > next_value
            @next_offset = next_value
        else
            @next_offset = nil
        end
        if prev_value > 0
            @prev_offset = prev_value
        elsif offset == 0
            @prev_offset = nil
        else
            @prev_offset = 0
        end

        @mails = Email.where('profile_id = ?', profile_id)
                      .order('mail_initiate_time desc').limit(limit).offset(offset)
    end

    def messages
        email_unique_id = params[:id]
        @email= Email.find(email_unique_id)
        profile_id = @email.profile_id
        @profile = Profile.find(profile_id)
        @messages = MailMessage.where('email_unique_id = ?',email_unique_id)
                   .order('message_time asc')
    end

end
