require 'thor'
require 'flight'
require 'flight/brewfile'

module Flight
  class Executable < Thor
    include Thor::Actions

    source_root File.expand_path('../../templates', __FILE__)

    desc :install, "Install Homebrew packages."
    def install
      update_brew and
      brewfile.packages.each { |pkg| use pkg } and
      say("Your flight is complete!\nPackages have been installed to #{prefix}.")
    end

    desc :update, "Update all Homebrew packages and edit the lockfile"
    def update
      update_brew and brewfile.packages.outdated.each { |pkg| use pkg }
    end

    desc :update, "List all outdated Homebrew packages"
    def outdated
      update_brew and brewfile.packages.outdated.each do |pkg|
        say "Current #{pkg.name} is #{pkg.current}, you have #{pkg.version}"
      end
    end

    desc :generate, "Create a Brewfile in this directory."
    def generate
      template 'Brewfile', 'Brewfile'
    end

    private
    def use(package)
      if package.installed?
        say "Using #{package}"
      else
        brew :install, "#{package.name} #{package.options}"
        say "Installed #{package}"
      end
    end

    def brewfile
      @brewfile ||= Brewfile.parse!
    end

    def update_brew
      install_source unless brewfile.default_source?
      brewfile.taps.unknown.each { |package| brew :tap, tap }
      brew :update
    end

    def brew(command, arguments='')
      if Flight.debug?
        run "brew #{command} #{arguments} --quiet"
      else
        system "brew #{command} #{arguments} --quiet"
      end
    end

    def prefix
      `brew --prefix`.strip
    end

    private
    def install_source
      system %[
        cd $(brew --prefix) &&
        git remote rm flight-source;
        git remote add flight-source #{brewfile.source_repository} &&
        git branch --set-upstream-to=flight-source/master &&
        git fetch flight-source
      ] or raise "Source '#{brewfile.source_repository}' could not be loaded."
     end
  end
end
