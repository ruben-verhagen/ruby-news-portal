xml.instruct! :xml, :version => '1.0'
xml.rss :version => '2.0' do
  xml.channel do
    xml.title site_setting(:title)
    xml.description site_setting(:meta_description)
    xml.link root_url

    for post in @posts
      xml.item do
        xml.title post.headline
        xml.description post.byline
        xml.pubDate post.published_at.to_s(:rfc822)
        xml.link post_url(post)
        xml.guid post_url(post)
      end
    end
  end
end