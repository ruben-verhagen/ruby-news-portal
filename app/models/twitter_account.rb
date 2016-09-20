class TwitterAccount < ActiveRecord::Base
  validates_presence_of :access_token, :access_token_secret, :username

  validates_uniqueness_of :uid

  def self.from_omniauth(data)
    TwitterAccount.create(uid: data['uid'], username: data['info']['nickname'], url: data['info']['urls']['Twitter'],
                          access_token: data['credentials']['token'],
                          access_token_secret: data['credentials']['secret'])
  end

  def self.has_twitter_account?
    TwitterAccount.count > 0
  end
end
