module Hcaptcha
  module Helpers
    module FormHelper
      def hcaptcha_tag(**options)
        tags = ''
        tags <<  content_tag('div', '', id: 'captcha-1', class: 'h-captcha', data: hcaptcha_data_attributes(options))
        tags << javascript_include_tag('https://hcaptcha.com/1/api.js', async: true, defer: true)

        if options[:size] == 'invisible'
          tags << raw(hcaptcha_script(options[:input_id] || 'captcha-1'))
        end

        raw tags
      end

      private

      def hcaptcha_script(widget_id)
        raw <<~HTML
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
          sitekey: Hcaptcha.configuration.site_key,
          size: options[:size] || 'normal',
          theme: options[:theme] || 'normal'
        }

        if options[:size] == 'invisible'
          data.merge!(callback: options[:callback] || 'captchaValidated')
        end

        data
      end
    end
  end
end
