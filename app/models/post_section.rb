class PostSection < ActiveRecord::Base
  include Concerns::Sluggable

  has_many :post_sections_posts, dependent: :destroy
  has_many :posts, through: :post_sections_posts

  has_many :subsections, foreign_key: :parent_id, class_name: 'PostSection'
  belongs_to :parent, foreign_key: :parent_id, class_name: 'PostSection'

  scope :root,      -> { where(parent_id: nil) }
  scope :in_menu,   -> { where(in_top_menu: true) }

  validates :name, presence: true, length: { maximum: 255 }
  #validates :description, length: { maximum: 1_000 }

  mount_uploader :cover, PostSectionCoverUploader

  protected

  def slug_source
    name
  end
end