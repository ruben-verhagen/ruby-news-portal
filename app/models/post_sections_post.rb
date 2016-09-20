class PostSectionsPost < ActiveRecord::Base
  belongs_to :post
  belongs_to :post_section
end