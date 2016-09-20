class EmailAlertSchedulesPost < ActiveRecord::Base
  belongs_to :email_alert_schedule
  belongs_to :post
end
