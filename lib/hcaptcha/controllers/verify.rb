module Hcaptcha
  module Controllers
    module Verify
      private

      def verify_hcaptcha
        Hcaptcha.api_verification(params['h-captcha-response'])
      end
    end
  end
end
