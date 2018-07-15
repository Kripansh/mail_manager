class Profile < ApplicationRecord

EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
KEY = "x\xFF=o\xF3\x90p\xA6)\x13p\x8B\x9A\xB7tU\xDF\xC2\xDF2=s\xA4[\x80\xCA\xBF\x1A|\x0E\xEEq\xE0\xFC\xBDq\x85i\xC5\xE1 \xE5\xE5+Nm;\xAA\x99\xFF9\x13\xBFdh\x97\xBC\x942\xBF\x10\xF3\xAC\xAE"
attr_accessor :login_password
validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX

    def init_profile(params, account_id)
        self.account_id = account_id
        self.email = params[:email]
        self.encrypted_password = encrypt_password(params[:login_password])
        self.provider='GOOGLE'
        self.fetch_interval = 30 # in seconds
    end

    def encrypt_password(login_password)
        crypt = ActiveSupport::MessageEncryptor.new(KEY)
        encrypted_password = crypt.encrypt_and_sign(login_password)
        return encrypted_password
    end

    def decrypted_password()
        crypt = ActiveSupport::MessageEncryptor.new(KEY)
        decrypted_password = crypt.decrypt_and_verify(self.encrypted_password)
        return decrypted_password
    end
end
