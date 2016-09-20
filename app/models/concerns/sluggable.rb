module Concerns::Sluggable
  extend ActiveSupport::Concern

  included do
    extend FriendlyId

    validates :slug, uniqueness: true

    friendly_id :generated_slug, use: :slugged
  end


  def slug=(value)
    if value.present?
      write_attribute(:slug, value)
    end
  end

  def generated_slug
    source = slug_source if slug_source.present?

    [ source, [source, SecureRandom.random_number(1000)]]
  end
end
