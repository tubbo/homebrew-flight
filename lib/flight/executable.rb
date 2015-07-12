require 'thor'
require 'flight'
require 'flight/brewfile'

module Flight
  class Executable < Thor
    include Thor::Actions

    source_root File.expand_path('../../templates', __FILE__)

    default_task :bundle

    desc :install, 'Install all configured packages'
    method_option :kinds, type: :array, alias: '-k', default: %w(packages casks)
    def bundle
      say "Fetching Homebrew packages and casks..."

      kinds = { 'brew' => 'packages', 'brew cask' => 'casks' }
      kinds.delete('brew') unless options[:kinds].include('packages')
      kinds.delete('brew cask') unless options[:kinds].include('casks')

      kinds.each do |program, manifest|
        File.open(File.expand_path("~/etc/brew/#{manifest}")).each_line.map do |formula|
          formula.strip
        end.each do |formula|
          use formula, program
        end
      end

      say "Your flight is complete!"
      say "Packages have been installed to #{prefix}."
    end

    desc 'package NAME', "Install a package"
    method_option :cask, type: :boolean, default: false
    def package(formula)
      use formula
    end

    desc 'cask NAME', "Install a cask from Caskroom"
    def cask(formula)
      use formula, program: 'brew cask'
    end

    desc :init, "Initialize your home directory for use with Flight"
    def init
      system "mkdir -p ~/etc/brew"
      system "brew list > ~/etc/brew/packages"
      system "brew cask list > ~/etc/brew/casks"
      say "Currently installed packages written to ~/etc/brew/packages and ~/etc/brew/casks"
    end

    private
    def use(formula, program: 'brew')
      info = `#{program} info #{formula}`
      version = info.split("\n").first.gsub(/#{formula}: /, '')

      if info.include?('Not installed')
        say "Installing #{formula} @ #{version}..."
        system "#{program} install #{formula} 2&>1"
      else
        say "Using #{formula} #{version}"
      end
    end
  end
end
