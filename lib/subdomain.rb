class Subdomain
  def self.matches?(request)
    host = Rails.application.routes.default_url_options[:host]
    subdomain = (request.subdomain.split('.') - host.split('.')).first

    subdomain.present? && subdomain != 'www'
  end

  def self.without_subdomain
    { subdomain: Rails.application.routes.default_url_options[:host].split('.')[0...-2].join('.') }
  end
end