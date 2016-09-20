require 'net/http'
require 'net/https'

class XtenitService
  DOMAIN_URL       = 'https://marketnews-m.a.xtenit.com/'
  CONTENT_FEED_URL = DOMAIN_URL + 'webaccess/contentfeed'
  MEMBERSHIP_URL   = DOMAIN_URL + 'webaccess/Membership'
  PUSH_MEMBER_URL  = DOMAIN_URL + 'webaccess/MemberPush'

  def initialize
    @credentials = Rails.application.secrets[:xtenit]
  end

  def update_member(user, action: 'update')
    form_data = {
      username: @credentials['username'],
      passwd: @credentials['password'],
      resulttype: 'xml',
      xml: XtenitXmlBuilder.update_member(user, action)
    }

    response = post_request(PUSH_MEMBER_URL, form_data)
    response['results']['status'] == 'success'
  end

  def send_posts(posts, emails, greeting)
    form_data = {
      username: @credentials['username'],
      passwd: @credentials['password'],
      resulttype: 'xml',
      xml: XtenitXmlBuilder.send_post(posts, emails, greeting)
    }

    response = post_request(CONTENT_FEED_URL, form_data)
    response['result'] == 'Run now'
  end

  def post_request(url, data)
    uri = URI.parse(url)

    Hash.from_xml Net::HTTP.post_form(uri, data).body
  end
end