module Hcaptcha
  class Configuration
    attr_accessor :site_key, :secret_key, :api_script_url
    attr_reader :verify_url

    def initialize
      @site_key = nil
      @secret_key = nil
      @api_script_url = 'https://hcaptcha.com/1/api.js'
      @verify_url = URI('https://hcaptcha.com/siteverify')
    end

    def verify_url=(value)
      @verify_url = URI(value)
    end
  end
end
