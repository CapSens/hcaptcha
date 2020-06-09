require 'hcaptcha/controllers/verify'

RSpec.describe Hcaptcha::Controllers::Verify do
  include Hcaptcha::Controllers::Verify

  let(:method_params) { double(params) }
  let(:params) { { 'h-captcha-response': h_captcha_response } }
  let(:h_captcha_response) { 'test' }

  describe 'verify_hcaptcha' do
    subject { verify_hcaptcha }

    it 'calls Hcaptcha.api_verification' do
      expect(Hcaptcha).to(
        receive(:api_verification).with(params['h-captcha-response']) { [true, {}] }
      )
      subject
    end
  end
end
