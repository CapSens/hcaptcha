module Hcaptcha
  module Helpers
    module FormHelper
      def hcaptcha_tag(**options)
        tags = ''
        tags << hcaptcha_input(options)
        tags << hcaptcha_script

        if options[:size] == 'invisible' && !options[:no_callback_script]
          tags << hcaptcha_invisible_script(options[:input_id] || 'captcha-1')
        end

        tags
      end

      private

      def hcaptcha_input(**options)
        <<~HTML
          <div
            id="captcha-1"
            class="h-captcha"
            #{formatted_data_attributes(options)}
          ></div>
        HTML
      end

      def hcaptcha_script
        <<~HTML
          <script src="#{Hcaptcha.configuration.api_script_url}" async defer></script>
        HTML
      end

      def hcaptcha_invisible_script(widget_id)
        <<~HTML
          <script type="text/javascript">
            let captcha_generated = false
            const current_form = document.getElementById('#{widget_id}').closest('form')

            function challengeBeforeSubmit() {
              if (captcha_generated === false) {
                event.preventDefault()
                hcaptcha.execute()
              }
            }

            function captchaValidated() {
              captcha_generated = true
              current_form.closest('form').submit()
            }

            current_form.closest('form').addEventListener('submit', challengeBeforeSubmit)
          </script>
        HTML
      end

      def hcaptcha_data_attributes(**options)
        data = {
          sitekey: options[:sitekey] || Hcaptcha.configuration.site_key,
          size: options[:size] || 'normal',
          theme: options[:theme] || 'normal'
        }

        data.merge!(callback: options[:callback] || 'captchaValidated') if options[:size] == 'invisible'

        data
      end

      def formatted_data_attributes(**options)
        hcaptcha_data_attributes(options).map { |key, value| "data-#{key}='#{value}'" }
                                         .join(' ')
      end
    end
  end
end
