class AutomaticEmailAlert < ActiveRecord::Base
  belongs_to :email_alert_schedule
  has_many :automatic_email_alerts_posts, dependent: :destroy
  has_many :posts, through: :automatic_email_alerts_posts
end
