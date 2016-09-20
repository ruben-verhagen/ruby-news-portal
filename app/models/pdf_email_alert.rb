class PdfEmailAlert < ActiveRecord::Base
  include ActionView::Helpers::SanitizeHelper

  before_save :sanitize_html

  serialize :user_groups, Array

  scope :latest, -> { order('updated_at DESC') }

  mount_uploader :file, PdfEmailAlertFileUploader

  enum status: { initial: 'initial', ready: 'ready', sent: 'sent', failed: 'failed' }

  validates_presence_of :user_groups, :greeting_message
  validates_length_of :greeting_message, maximum: 10_000
  validate :posts_presence

  def sanitize_html
    self.greeting_message = sanitize(self.greeting_message, tags: [], attributes: [])
  end

  def posts
    Post.published.weekly_digest.last_week
  end

  def user_groups=(value)
    super(value.reject(&:empty?))
  end

  protected

  def posts_presence
    if posts.empty?
      errors.add(:base, 'There are no posts to generate pdf')
    end
  end
end
