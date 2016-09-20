class TwitterPoster
  TWEET_POST_LENGTH = 140
  ALTERED_URL_LENGTH = 36

  def initialize(twitter_account_id)
    credentials = Rails.application.secrets.twitter
    account = TwitterAccount.find(twitter_account_id)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = credentials['consumer_key']
      config.consumer_secret = credentials['consumer_secret']
      config.access_token = account.access_token
      config.access_token_secret = account.access_token_secret
    end
  end

  def tweet_post(post, text)
    url = Rails.application.routes.url_helpers.post_url(post.id)

    length = determine_text_length(url)
    @client.update("#{text.truncate(length)} #{url}")
  end

  def tweet_custom_text(text)
    @client.update("#{text}")
  end

  def determine_text_length(url)
    if Rails.env.development?
      TWEET_POST_LENGTH - url.length - 1
    else
      TWEET_POST_LENGTH - ALTERED_URL_LENGTH - 1
    end
  end
end