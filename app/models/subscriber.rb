class Subscriber < ActiveRecord::Base
  validates :first_name, :last_name, :company, :phone_number, :email, presence: true
end