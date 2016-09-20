class Event < ActiveRecord::Base

  scope :nearest, -> (limit = 1) { where('happens_at > ?', Time.zone.now).order(:happens_at).limit(limit) }
  scope :in_ticker, -> { where(in_ticker: true) }

  validates :title, :happens_at, presence: true
  validates :title, length: { maximum: 255 }
  validates :description, length: { maximum: 5_000 }
end