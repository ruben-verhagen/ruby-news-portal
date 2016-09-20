require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"
require File.expand_path('../boot', __FILE__)
ENV['RANSACK_FORM_BUILDER'] = '::SimpleForm::FormBuilder'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mni
  class Application < Rails::Application

    config.assets.initialize_on_precompile = false

    config.action_view.sanitized_allowed_tags = %w[p strong b h1 h2 h3 a]
    config.action_view.sanitized_allowed_attributes = %w[]

    I18n.enforce_available_locales = false
    config.i18n.default_locale = :en
    config.time_zone = 'Brussels'

    config.autoload_paths += Dir["#{config.root}/lib/**",
                                 "#{config.root}/app/services/**",
                                 "#{config.root}/app/forms/**",
                                 "#{config.root}/app/models/ckeditor"
    ]

    config.to_prepare do
      Devise::DeviseController.layout 'simple'
      Devise::Mailer.layout 'email'
    end
  end
end
