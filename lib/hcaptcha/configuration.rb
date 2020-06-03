module Hcaptcha
  class Configuration
    attr_accessor :site_key, :secret_key, :verify_url

    def initialize
      @site_key = nil
      @secret_key = nil
      @verify_url = URI('https://hcaptcha.com/siteverify')
    end

    def verify_url=(value)
      binding.pry
      @verify_url = URI(value)
    end
  end
end
