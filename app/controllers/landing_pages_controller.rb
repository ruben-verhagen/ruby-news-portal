class LandingPagesController < FrontController
  layout 'landing'

  def show
    host = Rails.application.routes.default_url_options[:host]
    subdomain = (request.subdomain.split('.') - host.split('.')).first

    @landing_page = LandingPage.find_by(subdomain: subdomain)
  end

  def thanks
    host = Rails.application.routes.default_url_options[:host]
    subdomain = (request.subdomain.split('.') - host.split('.')).first

    @landing_page = LandingPage.find_by(subdomain: subdomain)
  end
end
