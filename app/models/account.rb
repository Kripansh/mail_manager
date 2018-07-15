class Account < ApplicationRecord

attr_accessor :username
attr_accessor :password
  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX

def init_account(params)
    self.account_name = params[:account_name]
    self.email=params[:email]
    self.phone=params[:phone]
    self.business_name=params[:business_name]
end

end
