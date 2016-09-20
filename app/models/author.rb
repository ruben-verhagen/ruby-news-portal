class Author < ActiveRecord::Base
  include Concerns::Sluggable

  has_and_belongs_to_many :posts
  validates :name, presence: true, length: { maximum: 255 }

  scope	:alphabetical, -> { order(:name) }
  mount_uploader :photo, AuthorPhotoUploader

  protected

  def slug_source
    name
  end
end