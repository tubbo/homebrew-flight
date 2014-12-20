require 'spec_helper'
require 'flight/package/options'

module Flight
  class Package
    RSpec.describe Options do
      let :hash do
        { with_ruby: true, perl: false }
      end

      subject do
        Options.new hash
      end

      it "converts options into query parameters" do
        expect(subject.to_s).to eq('--with-ruby --no-perl')
      end

      it "outputs options as a hash" do
        expect(subject.to_h).to eq(hash)
      end
    end
  end
end
