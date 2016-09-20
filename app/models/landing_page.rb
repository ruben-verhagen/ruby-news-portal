class LandingPage < ActiveRecord::Base
  validates_presence_of :title, :subdomain
  validates_uniqueness_of :subdomain
  validates :subdomain, format: { with: /\A[a-z0-9-]+\z/ }
  validates_length_of :subdomain, minimum: 2, maximum: 15
  validates_length_of :title, minimum: 5, maximum: 150
  validates_length_of :left_column_content, :right_column_content, :center_column_content, :thanks_content, maximum: 10_000
end
