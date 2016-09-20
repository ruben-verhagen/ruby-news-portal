class Admin::DashboardController < AdminController
  def index
    @posts_in_digest_count = Post.published.weekly_digest.last_week.count

    @total_post_page_views = Post.pageviews
    @total_post_unique_visitors = Post.unique_visitors
    @total_page_views = Impression.count

    posts = Post.published.by_views.limit(20)
    periods = [:yesterday, :last_week, :last_month, :all_time]

    @post_views_data = {}
    periods.each do |period|
      range = period_to_range(period)
      @post_views_data[period] = posts.where(published_at: range)
    end
  end

  def weekly_digest
    posts = Post.published.weekly_digest.last_week.ranked
    generator = ArticlePdfGenerator.new(posts, date: I18n.l(Time.zone.now, format: :short))

    respond_to do |format|
      format.pdf { send_data generator.render, filename: "MNI-Euro-Insight-weekly-briefing-#{ I18n.l Date.today }.pdf" }
    end
  end


  protected

  def period_to_range(period)
    case period
      when :yesterday   then Time.zone.yesterday.beginning_of_day..Time.zone.yesterday.end_of_day
      when :last_week   then 7.days.ago.beginning_of_day..Time.zone.yesterday.end_of_day
      when :last_month  then 1.month.ago.beginning_of_day..Time.zone.yesterday.end_of_day
      when :all_time    then Time.at(0)..Time.zone.now
    end
  end

  def weekly_digest_range
    start_week_date = (Time.zone.now - 7.days - ((Time.zone.today.cwday - 1)%7).days).beginning_of_day
    end_week_date = (start_week_date + 6.days).end_of_day

    (start_week_date..end_week_date)
  end
end