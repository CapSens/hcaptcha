require 'json'
require 'net/http'
require 'uri'

require 'hcaptcha/configuration'
require 'hcaptcha/version'

module Hcaptcha
  class Error < StandardError; end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def verify_hcaptcha(hcaptcha_response)
    response = Net::HTTP.post_form(configuration.verify_url, **build_payload(hcaptcha_response))
    response_json = JSON.parse(response.body)
    success = response_json['success']
  end

  def build_payload(hcaptcha_response)
    { 'secret': configuration.secret_key, 'response': params['h-captcha-response'] }
  end
end
