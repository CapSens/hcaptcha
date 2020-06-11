require 'json'
require 'net/http'
require 'uri'

require 'hcaptcha/configuration'
require 'hcaptcha/version'

require 'hcaptcha/railtie' if defined?(Rails)

module Hcaptcha
  class Error < StandardError; end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def api_verification(token)
      response = Net::HTTP.post_form(configuration.verify_url, **build_payload(token))
      response_json = JSON.parse(response.body)
      success = response_json['success']
      [success, response_json]
    rescue StandardError => e
      raise(Hcaptcha::Error.new(e))
    end

    def build_payload(token)
      { 'secret': configuration.secret_key, 'response': token }
    end
  end
end
