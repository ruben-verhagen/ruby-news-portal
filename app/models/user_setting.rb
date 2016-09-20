class UserSetting < ActiveRecord::Base
  DEFAULT = { email_alerts: true, cookie: true }

  validates_presence_of :cookie

  belongs_to :user
end
