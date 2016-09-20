class SalesManager < ActiveRecord::Base
  validates_uniqueness_of :email
  validates_presence_of :email, :name
end
