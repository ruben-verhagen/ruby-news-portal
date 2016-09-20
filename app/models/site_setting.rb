class SiteSetting < ActiveRecord::Base
  validates :code, :name, length: { maximum: 255 }
  validates :value, length: { maximum: 10_000 }
end