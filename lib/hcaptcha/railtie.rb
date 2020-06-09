require 'hcaptcha/controllers/verify'
require 'hcaptcha/helpers/form_helper'

module Hcaptcha
  class Railtie < Rails::Railtie
    ActiveSupport.on_load(:action_controller) { include Hcaptcha::Controllers::Verify }

    ActiveSupport.on_load(:action_view) { include Hcaptcha::Helpers::FormHelper }
  end
end
