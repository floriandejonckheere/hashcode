# frozen_string_literal: true

RSpec.describe HashCode::Options do
  subject(:options) { described_class.new }

  it { is_expected.to respond_to :verbose, :verbose?, :verbose= }
  it { is_expected.to respond_to :debug, :debug?, :debug= }

  describe "#[]" do
    it "gets the option value" do
      options.debug = true

      expect(options[:debug]).to eq true
    end
  end

  describe "#[]=" do
    it "sets the option value" do
      options[:debug] = true

      expect(options.debug).to eq true
    end
  end
end
