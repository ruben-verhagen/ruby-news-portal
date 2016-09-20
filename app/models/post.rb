class Post < ActiveRecord::Base
  attr_accessor :email_alert_description
  include Concerns::Sluggable
  include RankedModel

  self.per_page = 20

  acts_as_taggable
  serialize :countries, Array
  enum visibility: { green: 'green', yellow: 'yellow', red: 'red', silver: 'silver' }

  ranks :rank
  ranks :carousel_rank, scope: :for_carousel
  is_impressionable counter_cache: true, column_name: :views

  after_commit :disable_all_ledes
  before_save :set_published_at
  before_save :reject_empty_countries

  has_many :post_sections_posts, dependent: :destroy
  has_many :post_sections, through: :post_sections_posts

  has_many :authors_posts
  has_many :authors, through: :authors_posts
  has_many :email_alerts_posts
  has_many :email_alerts, through: :email_alerts_posts

  has_many :automatic_email_alerts_posts, dependent: :destroy
  has_many :automatic_email_alerts, through: :automatic_email_alerts_posts

  validates :visibility, presence: true
  validates :headline, :byline, length: { maximum: 255 }
  validates :cover_description, length: { maximum: 1_000 }
  validates :headline, :content, presence: true
  validates :cover, file_size: { maximum: 5.megabytes }
  validates :content, length: { maximum: 100_000 }

  #validates :twitter_text, length: { maximum: 120 }, presence: true
  validates :published_at, presence: true, if: -> { self.published }

  validate :one_author_at_least

  mount_uploader :cover, PostCoverUploader
  mount_uploader :video_mp4, VideoMp4Uploader
  mount_uploader :video_webm, VideoWebmUploader

  scope :in_ticker,           -> { where(in_ticker: true) }

  scope :latest,              -> { order('published_at DESC') }
  scope :published,           -> { where(published: true).where.not(published_at: nil).where('published_at < ?', Time.zone.now) }
  scope :authors_pick,        -> { where(authors_pick: true) }
  scope :top_lede,            -> { where(top_lede: true) }
  scope :breaking_news,       -> { where(is_breaking_news: true) }
  scope :with_image,          -> { where.not(cover: nil) }
  scope :weekly_digest,       -> { where(in_digest: true) }
  scope :for_automatic_alert, -> { where(in_automatic_email: true) }
  scope :for_carousel,        -> { with_image.where(in_carousel: true) }

  scope :featured,            -> (level=1) { where(featured_level: level)}
  scope :ranked,              -> { rank(:rank) }

  scope :last_week,           -> { where('published_at >= :date', date: 1.week.ago) }
  scope :by_views,            -> { order('views DESC') }


  class << self
    def pageviews
      Impression.where(impressionable_type: 'Post').where.not(impressionable_id: nil).count
    end

    def unique_visitors
      Impression.select(:session_hash).where(impressionable_type: 'Post').distinct.count
    end
  end


  def pageviews(range_params)
    impressionist_count(range_params)
  end

  def unique_visitors(range_params)
    impressionist_count(range_params.merge({ filter: :session_hash }))
  end

  def author_names
    self.authors.map { |p| p.name }.join(', ')
  end

  def visible_for?(user)
    if user.nil?
      self.green? || (self.yellow? && self.published_at <= 2.days.ago) || (self.red? && self.published_at <= 7.days.ago)
    else
      true
    end
  end

  def should_alert_via_twitter?
    self.published? && !self.alerted_via_twitter
  end

  def headline_with_alerted_mark
    "#{self.headline} #{self.automatic_email_alerts.count > 0 ? '<b>(alerted with auto mailing)</b>' : ''}".html_safe
  end

  protected

  def one_author_at_least
    if authors.size == 0
      errors.add(:authors, 'You need to add at least one author')
    end
  end

  def disable_all_ledes
    if self.top_lede
      Post.top_lede.where.not(id: self.id).each do |post|
        post.top_lede = false
        post.save
      end
    end
  end

  def set_published_at
    if published && !published_at
      self.published_at = Time.zone.now
    end
  end

  def reject_empty_countries
    self.countries = self.countries.reject(&:empty?)
  end

  def slug_source
    [headline, rand(10_000) + 100]
  end
end
