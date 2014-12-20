require "flight/version"
require "flight/executable"

# Flight is a dependency manager for your Homebrew packages. This is the
# base module that includes configuration, global attributes, and
# requires to the actual code. Most of the codebase lies in the data
# models of Package and Tap, with the Executable being the "controller"
# to the UI.

module Flight
  DEBUG = ENV['FLIGHT_DEBUG']

  def self.version
    VERSION
  end

  def self.debug?
    !!DEBUG
  end
end
