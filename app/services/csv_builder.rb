require 'csv'

class CSVBuilder
  def self.build_from_users(users)
    CSV.generate do |csv|
      csv << ['Id', 'Email', 'Group', 'First name', 'Last name', 'Title', 'Company', 'Phone number', 'Created at']

      users.each do |user|
        csv << [user.id, user.email, user.user_group.humanize, user.first_name, user.last_name, user.title, user.company, user.phone_number, I18n.l(user.created_at, format: :post_list)]
      end

      csv
    end
  end
end