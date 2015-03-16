module Mailadm
  class User < Sequel::Model(:users)
    plugin :validation_helpers

    attr_accessor :password #, :password_confirmation

    def validate
      super
      validates_presence :password, :on => :create
      validates_unique([:username, :domain])
    end

    def before_save
      encrypt_password
      super
    end

    def self.authenticate(email, password)
      username, domain = email.split('@')
      user = User.where(:username => username, :domain => domain).first
      user && user.has_password?(password) ? user : nil
    end

    def has_password?(password)
      ::UnixCrypt.valid?(password, password_digest)
    end

    private
    def encrypt_password
      self.password_digest = ::UnixCrypt::SHA512.build(password, SecureRandom.hex(4))
    end
  end
end
