class ApplicationMailer < ActionMailer::Base
  default :from => 'MNI Euro Insight Notifications <notifications@mni-news.com>'

  def new_subscriber_email(user)
    @user = user
    @emails = SalesManager.pluck(:email)

    if @emails.any?
      mail(to: @emails.join(', '), subject:  'MNI Euro Insight / New Subscriber')
    end
  end
end