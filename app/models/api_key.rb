require 'settings'
class ApiKey < ActiveRecord::Base
  TOKEN_LIFETIME = eval Settings.token_lifetime

  before_create :update_token_expire

  belongs_to :user

  scope :fresh, ->{ where('expires_at > ?', [Time.now]) }

  def refresh!
    update_token_expire
    save!
  end

  private

  def update_token_expire
    set_token unless token
    set_expires_at
  end

  def set_token
    begin
      self.token = SecureRandom.hex
    end while self.class.exists?(token: token)
  end

  def set_expires_at
    self.expires_at = Time.now+TOKEN_LIFETIME
  end

end
