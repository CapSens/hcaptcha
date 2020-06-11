require 'hcaptcha/helpers/form_helper'

RSpec.describe Hcaptcha::Helpers::FormHelper do
  include Hcaptcha::Helpers::FormHelper

  describe '.hcaptcha_tag' do
    subject { hcaptcha_tag(**options) }

    before do
      allow(Hcaptcha).to receive_message_chain(:configuration, :site_key) { 'default' }
    end

    context 'without option' do
      let(:options) { {} }

      it 'renders a div with h-captcha class' do
        expect(subject).to match(/^<div.*class=.*h-captcha.*><\/div>/m)
      end

      it 'includes default sitekey in input data-attributes' do
        expect(subject).to match(/data-sitekey=['|"]default/)
      end

      it 'includes basic hcaptcha script' do
        expect(subject).to match(/<script src="https:\/\/hcaptcha.com\/1\/api.js" async defer><\/script>/m)
      end
    end

    context 'with random options' do
      let(:options) { { sitekey: 'test', size: 'compact', theme: 'dark' } }

      it 'includes all the options given as data attributes' do
        result = subject
        expect(result).to match(/data-sitekey=['|"]test/)
        expect(result).to match(/data-size=['|"]compact/)
        expect(result).to match(/data-theme=['|"]dark/)
      end
    end

    context 'with size="invisible" option' do
      let(:options) { { size: 'invisible' } }

      it 'adds the data-callback option' do
        expect(subject).to match(/data-callback=['|"]captchaValidated/)
      end

      it 'adds a script with default callback function' do
        expect(subject).to match(/<script.*>.*function captchaValidated\(\).*<\/script>/m)
      end

      it 'adds a challengeBeforeSubmit js function binded on form submit' do
        result = subject
        expect(result).to match(/<script.*>.*function challengeBeforeSubmit\(\).*<\/script>/m)
        expect(result).to match(/addEventListener\('submit', challengeBeforeSubmit\)/)
      end

      context 'with custom callback function' do
        let(:options) { { size: 'invisible', callback: 'customFunction' } }

        it 'adds the data-callback custom function' do
          expect(subject).to match(/data-callback=['|"]customFunction/)
        end
      end

      context 'with no_callback_script option' do
        let(:options) { { size: 'invisible', no_callback_script: 'any_value' } }

        it 'does not add js script from hcaptcha gem' do
          expect(subject).not_to match(/<script type=['|"]text\/javascript>/)
        end
      end
    end
  end
end
