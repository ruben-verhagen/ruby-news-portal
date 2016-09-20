require 'net/http'
require 'net/https'
require 'uri'

class SSOUsersProcessor
  ROLE = 'IEUR'
  URL = 'https://contracts.deutsche-boerse.com/vfs/mni_user_export/user.xml'

  def initialize
    @uri = URI.parse(URL)
    @req = Net::HTTP::Get.new(@uri.path)
    @auth_data = Rails.application.secrets.sso

    @user_data = SSOXmlParser.new(retrieve_sso_user_data).parse
  end


  def update_user_groups
    @user_data.each do |sso_user_data|
      if has_application?(sso_user_data, ROLE)
        user = User.find_by(email: sso_user_data[:email]) ||
               User.create(email: sso_user_data[:email], last_name: sso_user_data[:last_name],first_name: sso_user_data[:first_name], user_group: :subscriber)

        update_user(user, sso_user_data)
        transfer_user(user)
      end
    end

    puts 'Users SSO Update: trialists were successfully updated'
  end

  def expire_excluded
    paying_emails = @user_data.map { |u| u[:email] }
    expired_users = User.in_sso.where.not(email: paying_emails)
    updated_count = expired_users.count

    expired_users.each(&:email_registrant!)

    puts "Users SSO Update: #{updated_count} users have been expired"
  end

  protected

  def update_user(user, data)
    application_data = data[:applications].select { |app| app[:role] == ROLE }.first

    if application_data[:expires_at].present?
      begin
        expires_at = DateTime.parse(application_data[:expires_at])
        user.update(expires_at: expires_at)
      rescue ArgumentError => e
        puts "Invalid end_date from SSO for user #{user.email}"
      end
    else
      user.update(expires_at: nil)
    end

  end

  def transfer_user(user)
    if user.trial_registrant? || user.email_registrant?
      user.subscriber!
    end

    if user.expires_at && Time.zone.now < user.expires_at
      user.trialist!
    else
      unless user.subscriber?
        user.subscriber!
      end
    end
  end

  def retrieve_sso_user_data
    @req.basic_auth @auth_data['user'], @auth_data['password']

    http = Net::HTTP.new(@uri.host, 443)
    http.use_ssl = true
    resp = http.start {|http| http.request(@req)}

    xml = resp.body

    doc = Nokogiri::Slop(xml)

    doc.users.user
  end

  def has_application?(user, role)
    user[:applications].any? {|app| app[:role] == role }
  end
end