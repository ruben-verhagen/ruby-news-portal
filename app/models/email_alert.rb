class EmailAlert < ActiveRecord::Base
  include ActionView::Helpers::SanitizeHelper

  serialize :user_groups, Array
  before_save :sanitize_html

  has_many :email_alerts_posts, dependent: :destroy
  has_many :posts, through: :email_alerts_posts

  scope :latest, -> { order('updated_at DESC') }
  accepts_nested_attributes_for :email_alerts_posts

  enum status: { initial: 'initial', ready: 'ready', sent: 'sent', failed: 'failed' }

  validates_presence_of :user_groups, :post_ids, :subject
  validates_length_of :greeting_message, maximum: 5_000
  validates_length_of :subject, maximum: 255

  def sanitize_html
    self.greeting_message = sanitize(self.greeting_message, tags: [], attributes: [])
  end

  def user_groups=(value)
    super(value.reject(&:empty?))
  end
end