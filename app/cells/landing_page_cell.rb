class LandingPageCell < FrontendCell

  def right_column_content
    host = Rails.application.routes.default_url_options[:host]
    subdomain = (request.subdomain.split('.') - host.split('.')).first
    @main_host = host.gsub("#{subdomain}.", '')

    @landing_page = LandingPage.find_by(subdomain: subdomain)
    @post = Post.order(created_at: :desc).first
    render
  end

  def left_column_content
    host = Rails.application.routes.default_url_options[:host]
    subdomain = (request.subdomain.split('.') - host.split('.')).first

    @landing_page = LandingPage.find_by(subdomain: subdomain)

    render
  end
end
