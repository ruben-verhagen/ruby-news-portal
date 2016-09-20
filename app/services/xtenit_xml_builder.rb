class XtenitXmlBuilder
  APP_ID = 1937
  MAX_RETRY = 3

  def self.update_member(user, action)
    Nokogiri::XML::Builder.new do |xml|
      xml.data do
        xml.params notify: 'true', 'default-action' => action, verify: 'false' do
          xml.record email: user.email, action: action do
            xml.app '', appid: APP_ID, action: 'active'
            xml.user type: 'receiver' do
              xml.email user.email
            end
          end
        end
      end

    end.doc.to_s
  end

  def self.send_post(posts, emails, greeting)

    summary = ActionView::Base.new(
                Rails.configuration.paths["app/views"]).render(
                partial: 'admin/email_alerts/newsletter', format: :html,
                locals: { posts: posts, greeting: greeting })

    Nokogiri::XML::Builder.new do |xml|
      xml.schedule do
        xml.delay 0
        xml.data do
          xml.ContentFeed do
            xml.params do
              xml.appid APP_ID
              xml.maxretry MAX_RETRY
              xml.notifyaddress 'notifications@mni-news.com'
              xml.addtype 'send'
            end
            xml.content sourcetype:'xtenit' do
              xml.messages do
                xml.message do
                  xml.meta '', special: 1, standalone: 1 do
                    xml.summary summary
                    xml.summarytype 'html'
                    xml.title 'MNI Euro Insight / Latest news'
                  end
                  xml.rules do
                    xml.finalaction 'exclude'
                    xml.rule name: "1" do
                      xml.if 'discinc'
                      xml.paren loper: 'or' do
                        xml.condition oper: 'match' do
                          xml.ref 'user/email'
                          emails.each do |email|
                            xml.list email
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end.doc.to_s
  end

end