module Hcaptcha
  class Configuration
    attr_accessor :site_key, :private_key, :verify_url

    def initialize
      @site_key = nil
      @private_key = nil
      @verify_url = nil
    end
  end
end
