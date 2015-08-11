require 'user_authenticator'
class User < ActiveRecord::Base
  include UserAuthenticator
  validates_presence_of :name, :email, :salt, :crypted_password
  has_one :api_key
  has_many :posts
  PUBLIC_ATTRIBUTES = [
    "id", "name", "email"
  ]

  def obtain_api_key
    api_key || ApiKey.new(user_id: id)
  end
  def public_attributes
    attributes.slice(*PUBLIC_ATTRIBUTES)
  end
  def admin_data
    public_attributes.merge(token: api_key.try(:token))
  end
end
