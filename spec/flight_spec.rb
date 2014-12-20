require 'spec_helper'
require 'flight'

RSpec.describe Flight do
  it 'has a version number' do
    expect(Flight::VERSION).not_to be nil
    expect(Flight.version).to eq(Flight::VERSION)
  end

  it 'detects if we are in debug mode' do
    expect(Flight::DEBUG).to be_nil
    expect(Flight.debug?).to eq(false)
  end
end
