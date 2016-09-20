namespace :automatic_email_alerts do
  task :send => :environment do
    include Admin::ApplicationHelper

    def log(message)
      puts PREFIX + message
    end

    PREFIX = 'AUTOMATIC_EMAIL_ALERTS: '
    schedule = EmailAlertSchedule.current

    if schedule
      last = schedule.automatic_email_alerts.order('created_at desc').first

      if last && Time.zone.now - last.created_at < 23.hours
        log 'Auto Email alert failed because of frequent usage'
      else

        posts = AutomaticEmailAlertsPost.collect_posts

        if posts.count == 0
          log 'There are no posts to send'
        else
          posts_hash = posts.map { |post| { post_id: post.id, headline: post.headline, description: post.byline } }
          auto_email_alert = AutomaticEmailAlert.create(email_alert_schedule: schedule)
          posts.each { |post| AutomaticEmailAlertsPost.create(post: post, automatic_email_alert: auto_email_alert) }

          if MailgunService.new.send_posts posts_hash, schedule.user_groups, 'MNI Euro Insight / Latest news',
                                           prepare_for_html(schedule.greeting_message)
            log 'Auto Email alert was successfully sent'
          else
            log 'Auto Email alert failed. Retry later'
          end
        end
      end

    else
      log 'There is no schedule on this time'
    end
  end
  
end