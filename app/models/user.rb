require 'user_authenticator'
class User < ActiveRecord::Base
  include UserAuthenticator
  validates_presence_of :name, :email, :salt, :crypted_password
  has_one :api_key
  has_many :posts

  def obtain_api_key
    api_key || ApiKey.new(user_id: id)
  end
end
