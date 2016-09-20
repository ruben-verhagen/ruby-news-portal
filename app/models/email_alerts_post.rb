class EmailAlertsPost < ActiveRecord::Base
  validates_uniqueness_of :email_alert_id, scope: :post_id
  belongs_to :email_alert
  belongs_to :post

  validates :headline, presence: true, length: { maximum: 255 }, if: -> { persisted? }
  validates :description, presence: true, length: { maximum: 1_000 }, if: -> { persisted? }
end