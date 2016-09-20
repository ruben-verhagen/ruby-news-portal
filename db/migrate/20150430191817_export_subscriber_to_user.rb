class ExportSubscriberToUser < ActiveRecord::Migration
  def up
    Subscriber.all.each do |sub|
      user = User.find_or_initialize_by(email: sub.email)
      user.update(first_name: sub.first_name, last_name: sub.last_name,
                  title: sub.title, company: sub.company, phone_number: sub.phone_number)

    end
  end

  def down

  end
end
