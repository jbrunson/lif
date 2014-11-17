class Identity < ActiveRecord::Base
  require 'rest_client'
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_for_oauth(auth)
    identity = find_by(provider: auth.provider, uid: auth.uid)
    identity = create(uid: auth.uid, provider: auth.provider) if identity.nil?
    identity
  end

  def refresh_token_if_expired
    if token_expired?
      env_domain = ENV["#{self.provider.upcase}_REFRESH_URL"]
      id = ENV["#{self.provider.upcase}_KEY"]
      secret = ENV["#{self.provider.upcase}_SECRET"]
      response    = RestClient.post env_domain, :grant_type => 'refresh_token', :refresh_token => self.refresh_token, :client_id => id, :client_secret => secret
      refreshhash = JSON.parse(response.body)

      token_will_change!
      token_expires_at_will_change!

      self.token     = refreshhash['access_token']
      self.token_expires_at = DateTime.now + refreshhash["expires_in"].to_i.seconds
      self.save
    end
  end

  def token_expired?
    return true if self.token.nil? || self.token_expires_at.nil?
    expiry = Time.at(self.token_expires_at) 
    return true if expiry < Time.now # expired token, so we should quickly return
    expires_at = expiry
    save if changed?
    false # token not expired. :D
  end
end