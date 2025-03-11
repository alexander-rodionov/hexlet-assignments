# frozen_string_literal: true

require 'byebug'

class SetLocaleMiddleware
  attr_reader :app

  def initialize(app)
    @app = app
  end

  # BEGIN
  def call(env)
    default_locale = I18n.default_locale.to_s
    international_locale = :en
    current_locale = env['HTTP_ACCEPT_LANGUAGE'] || default_locale
    current_locale = current_locale[0..1].to_sym
    current_locale = international_locale unless I18n.available_locales.include? current_locale
    I18n.locale = current_locale
    # Rack::Request.new(env).params.include?('locale')
    # unless Rack::Request.new(env).params.include?('locale')
    #   env['QUERY_STRING'] =
    #     update_query_string(env['QUERY_STRING'], 'locale',
    #                         current_locale.to_s)
    # end
    app.call(env)
  end

  def update_query_string(query_string, param_name, new_value)
    params = Rack::Utils.parse_nested_query(query_string)
    params[param_name] = new_value
    Rack::Utils.build_nested_query(params)
  end
  # END
end
