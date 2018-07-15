class MailSyncJob < ApplicationJob
  queue_as :default

  def perform(profile_id)
    profile = Profile.find(profile_id)
    username = profile.email
    password = profile.decrypted_password
    created_date = profile.created_at.strftime("%Y-%m-%d" )
    fetch_interval = profile.fetch_interval
    Gmail.connect(username, password) do |gmail|
            counter = 0
            # start date logic should be there
            gmail.inbox.emails(:unread, :after => Date.parse(created_date)).each do |email|
                subject = email.subject
                if(subject.start_with?('Re: '))
                    subject[0..3] = ""
                end
                if(subject.start_with?('Fwd: '))
                    subject[0..4] = ""
                end
                found_mail = Email.where('profile_id = ? AND subject = ?', profile_id,subject).first
                if(found_mail)

                else
                    mail = Email.new()
                    mail.subject = subject
                    mail.mail_initiate_time = email.message.date
                    mail.profile_id = profile_id
                    mail.save
                    found_mail = mail
                end
                unique_mail_id = found_mail.id

                mail_message = email.message
                plain_part = mail_message.multipart? ? (mail_message.text_part ? mail_message.text_part.body.decoded : nil) : mail_message.body.decoded
                html_part = mail_message.html_part ? mail_message.html_part.body.decoded : nil
                if(plain_part)
                    content = plain_part.encode!
                else
                    content = html_part.encode!
                end
                date = mail_message.date
                from = mail_message.from
                to = mail_message.to
                cc = mail_message.cc
                bcc = mail_message.bcc

                message = MailMessage.new
                message.email_unique_id = unique_mail_id
                message.message_content = content
                message.sender = from
                message.recipient = to
                message.cc = cc
                message.bcc = bcc
                message.message_time = date

                message.save

                email.read!
                counter = counter + 1
                if(counter == 10)
                    break
                end
            end
    end
    MailSyncJob.set(wait: 1.minute).perform_later(profile_id)
  end
end
