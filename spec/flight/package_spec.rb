require 'spec_helper'
require 'flight/package'

module Flight
  RSpec.describe Package do
    subject do
      Package.new(
        name: 'flight',
        version: '1.0.0',
        options: { with_ruby: true }
      )
    end

    it "converts params into attributes" do
      expect(subject.name).to eq('flight')
      expect(subject.version).to eq('1.0.0')
    end

    it "converts options param hash into options object" do
      expect(subject.options).to be_a(Package::Options)
    end

    it "finds current version from brew" do
      allow(subject).to receive(:info).and_return("flight: #{subject.version} stable, HEAD")
      expect(subject.current_version).to eq(subject.version)
    end

    it "is up to date when current_version matches version" do
      allow(subject).to receive(:info).and_return("flight: #{subject.version} stable, HEAD")
      expect(subject).to be_up_to_date
      expect(subject).to_not be_outdated
    end

    it "is outdated when current_version does not match version" do
      allow(subject).to receive(:info).and_return("flight: 2.0.0 (bottled)")
      expect(subject.current_version).to eq('2.1.1')
      expect(subject.current_version).to_not eq(subject.version)
      expect(subject).to be_outdated
      expect(subject).to_not be_up_to_date
    end

    it "is installed when 'Not Installed' can't be found in brew info" do
      allow(subject).to receive(:info).and_return("/usr/local/Cellar")
      expect(subject).to be_installed
    end

    it "is not installed when brew info tells us" do
      allow(subject).to receive(:info).and_return("Not Installed")
      expect(subject).to_not be_installed
    end

  end
end
