class Admin::TwitterAlertForm
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :twitter_text, :twitter_account_id

  validates :twitter_text, presence: true, length: { maximum: 120 }
  validates_presence_of :twitter_account_id

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
end