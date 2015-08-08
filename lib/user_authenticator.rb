require 'digest'
# handles auth and pw salting
module UserAuthenticator
  def authentic?(password)
    Digest::SHA2.hexdigest(password + salt) == crypted_password
  end
end
