RSpec.describe Hcaptcha do
  it "has a version number" do
    expect(Hcaptcha::VERSION).not_to be nil
  end

  describe '#configuration' do
    subject { described_class.configuration }

    it 'returns a Configuration instance' do
      expect(subject).to be_a(Hcaptcha::Configuration)
    end

    it 'memoize configuration' do
      configuration = subject
      expect(configuration).to eq(Hcaptcha.configuration)
      expect(configuration).not_to eq(Hcaptcha::Configuration.new)
    end
  end

  describe '#configure' do
    subject do
      described_class.configure do |config|
        config.site_key = 'site_key'
        config.secret_key = 'secret_key'
      end
    end

    it 'overrides initial configuration' do
      expect { subject }.to change { Hcaptcha.configuration.site_key }.from(nil).to('site_key')
      expect(Hcaptcha.configuration.secret_key).to eq('secret_key')
    end

    context 'when verify url is not valid' do
    end
  end

  describe '#api_verification' do
    subject { described_class.api_verification(token) }

    let(:token) { '10000000-aaaa-bbbb-cccc-000000000001' }
    let(:secret_key) { '0x0000000000000000000000000000000000000000' }

    before do
      described_class.configure do |config|
        config.secret_key = secret_key
      end
    end

    context 'when token is nil' do
      let(:token) { nil }

      it 'returns false' do
        expect(subject[0]).to eq(false)
      end
    end

    context 'whith an empty token' do
      let(:token) { '' }

      it 'returns false' do
        expect(subject[0]).to eq(false)
      end
    end

    context 'whith a valid token' do
      it 'returns true' do
        expect(subject[0]).to eq(true)
      end
    end

    context 'with an invalid verify_url' do
      it 'raises a Hcaptcha::Error' do
        allow_any_instance_of(Hcaptcha::Configuration).to receive(:verify_url) { URI('not_an_url') }
        expect { subject }.to raise_error(Hcaptcha::Error)
      end
    end
  end
end
