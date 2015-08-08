require 'digest'
class UserForm
  USER_ATTRIBUTES = [:crypted_password, :salt, :name, :email]
  attr_accessor :user

  def initialize(user, options)
    @options = options
    @user = user
    set_salt if options[:name].present?
    set_crypted_password if options[:password].present?
    @user.update_attributes(@options.slice(*USER_ATTRIBUTES))
  end

  def set_salt
    @options[:salt] = Digest::SHA2.hexdigest(@options[:name])
  end
 
  def set_crypted_password
    @options[:crypted_password] = encrypt_password(@options[:password], @options[:salt])
  end

  def encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + salt)
  end

end
