class Page < ActiveRecord::Base
  include Concerns::Sluggable
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, length: { maximum: 100_000 }

  validates :code, uniqueness: true


  protected

  def slug_source
    title
  end
end
