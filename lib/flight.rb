require "flight/version"
require "flight/executable"

module Flight
  DEBUG = ENV['FLIGHT_DEBUG']

  def self.version
    VERSION
  end

  def self.debug?
    !!DEBUG
  end
end
