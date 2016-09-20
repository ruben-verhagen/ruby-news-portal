require 'mailgun'

class MailgunService
  PREFIX = "euro_#{Rails.env}_"

  EMAIL_FROM = 'MNI Euro Insight Notifications <notifications@mni-news.com>'

  attr_accessor :mailgun

  def initialize
    @credentials = Rails.application.secrets[:mailgun]
    Mailgun.configure do |config|
      config.api_key = @credentials['api_key']
      config.domain  = @credentials['domain']
    end

    @mailgun = Mailgun()
  end

  def create_member(user, user_group)
    @mailgun.list_members("#{PREFIX}#{user_group}@#{@credentials['domain']}").add user.email
  rescue Mailgun::Error => e
    Rails.logger.info "#{user.email} #{e.message}"
  end

  def move_member(user)
    remove_member(user, user.previous_user_group)
    create_member(user, user.user_group)
  end

  def remove_member(user, user_group)
    if user_group.present?
      @mailgun.list_members("#{PREFIX}#{user_group}@#{@credentials['domain']}").remove user.email
    end
  rescue Mailgun::Error => e
    Rails.logger.info "#{user.email} #{e.message}"
  end

  def send_posts(posts, lists, subject, greeting)
    summary = ActionView::Base.new(
        Rails.configuration.paths["app/views"]).render(
        partial: 'admin/mailgun/newsletter', format: :html, layout: 'layouts/mailgun',
        locals: { posts: posts, greeting: greeting })
    summary = ActiveSupport::SafeBuffer.new(summary).to_str

    lists.each do |list|
      @mailgun.messages.send_email({ to: "#{PREFIX}#{list}@#{@credentials['domain']}", subject: subject,
                                     html: summary, from: EMAIL_FROM})
    end
  rescue Mailgun::Error => e
    Rails.logger.info "Error occurred while sending posts: #{e.message}"
  end

  def send_pdf(pdf_alert)
    summary = ActionView::Base.new(
        Rails.configuration.paths["app/views"]).render(
        partial: 'admin/mailgun/weekly_briefing', format: :html, layout: 'layouts/mailgun',
        locals: { greeting: pdf_alert.greeting_message })
    summary = ActiveSupport::SafeBuffer.new(summary).to_str
    pdf_alert.user_groups.each do |list|
      @mailgun.messages.send_email({ to: "#{PREFIX}#{list}@#{@credentials['domain']}", subject: 'MNI Euro Insight / Weekly Briefing',
                                     html: summary, from: EMAIL_FROM, attachment: File.new(pdf_alert.file.path)})
    end

  rescue Mailgun::Error => e
    Rails.logger.info "Error occurred while sending pdf: #{e.message}"
  end

  def send_subscription_message(user)
      summary = ActionView::Base.new(
          Rails.configuration.paths["app/views"]).render(
          partial: 'admin/mailgun/subscription', format: :html, layout: 'layouts/mailgun_footerless')
      summary = ActiveSupport::SafeBuffer.new(summary).to_str


      @mailgun.messages.send_email({ to: user.email, subject: 'MNI Euro Insight / Subscription',
                                     html: summary, from: EMAIL_FROM})
  rescue Mailgun::Error => e
    Rails.logger.info "#{user.email} #{e.message}"
  end

  def create_list(name)
    @mailgun.lists.create("#{PREFIX}#{name}@#{@credentials['domain']}")
  rescue Mailgun::Error => e
    Rails.logger.info "Error occurred while creating list: #{name}, #{e.message}"
  end
end
