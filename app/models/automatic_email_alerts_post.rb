class AutomaticEmailAlertsPost < ActiveRecord::Base
  belongs_to :automatic_email_alert
  belongs_to :post

  def self.collect_posts
    start_time = AutomaticEmailAlertsPost.order('created_at desc').first.try(:created_at) || (Time.zone.now - 7.days)
    end_time = Time.zone.now
    Post.published.for_automatic_alert.latest.where('published_at >= :start and published_at <= :end',
                                                    start: start_time, end: end_time)
  end
end
