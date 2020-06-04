require 'hcaptcha/controller_methods'
require 'hcaptcha/helpers/form_helper'

module Hcaptcha
  class Railtie < Rails::Railtie
    ActiveSupport.on_load(:action_controller) { include Hcaptcha::ControllerMethods }

    ActiveSupport.on_load(:action_view) { include Hcaptcha::Helpers::FormHelper }
  end
end
