class TickerCell < FrontendCell
  helper ApplicationHelper

  def show
    posts = apply_posts_scope(Post.all).in_ticker.latest.limit(10)
    events = Event.in_ticker.nearest.limit(4)
    now = Time.zone.now

    items = [
      posts.map   { |post|  { title: post.headline, date: post.published_at,  url: post_path(post) } },
      events.map  { |event| { title: event.title,   date: event.happens_at,   url: events_path } },
    ]

    @ticker_items = items.flatten.sort_by { |item| now - item[:date] }

    render 'show'
  end
end