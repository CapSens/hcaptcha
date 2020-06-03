require 'hcaptcha/controller_methods'

module Hcaptcha
  class Railtie < Rails::Railtie
    ActiveSupport.on_load(:action_controller) do
      include Hcaptcha::ControllerMethods
    end
  end
end
