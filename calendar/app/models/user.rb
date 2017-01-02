class User < ActiveRecord::Base
  has_many :entries
  has_many :challenges
  has_many :userprofiles
  has_many :challengestatuses
  def self.omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.image = auth.info.image
      user.email = auth.info.email
      user.token = auth.credentials.token
      user.expires_at = Time.at(auth.credentials.expires_at)
      user.role = 'user'
      user.displayname = auth.info.name
      user.save!
    end
  end
end
