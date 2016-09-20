class AuthorsPost < ActiveRecord::Base
  belongs_to :post
  belongs_to :author

  default_scope { order(:id) }
end
