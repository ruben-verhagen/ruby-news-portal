class SSOXmlParser
  def initialize(user_data)
    @user_data = user_data
  end

  def parse
    if @user_data.is_a? Nokogiri::XML::NodeSet
      @user_data.map do |user|
        parse_user(user)
      end
    else
      [parse_user(@user_data)]
    end
  end

  protected
  def parse_user(user)
    { email: user.email.content,
      first_name: user._name.firstname.content,
      last_name: user._name.lastname.content,
      username: user.email.content,
      applications: parse_application(user.applications.application) }
  end

  def parse_application(application_data)
    if application_data.is_a? Nokogiri::XML::NodeSet
      application_data.map do |app|
        app_data(app)
      end
    else
      [app_data(application_data)]
    end
  end

  def app_data(app_node)
    { key: app_node.attribute('key').content,
      expires_at: app_node.attribute('end_date').present? ? app_node.attribute('end_date').content : nil,
      role: app_node.role.content }
  end
end