# Flight

**WARNING:** Flight is untested and probably doesn't work.

Flight helps manage your [Homebrew][brew] packages in the same way
[Bundler][bundle] helps you manage gem dependencies. With your
`Brewfile`, you can tell Homebrew to install packages, configure build
options, and even install custom taps.

## Installation

Flight is a RubyGem, and for now you can only install it _with_
RubyGems:

```bash
$ gem install flight
```

You can also include it as a dependency in your Ruby project with
Bundler. Just add this line to your Gemfile and run `bundle`:

```ruby
gem 'flight'
```

## Usage

First of all, you'll need a Brewfile before you do anything else.
Generate one with the following command:

```bash
$ flight generate
```

Next, edit the Brewfile with the packages you want to install. You can
specify version constraints in the same manner as [Bundler][bundle] and
[Berkshelf][berks].

```ruby
brew 'vim'
brew 'git', '~> 2.2'
```

Once you're all done figuring out the packages you wish to install, it's
time to actually run Homebrew. Run the following command to install
every package and build a `Brewfile.lock` which saves the state of the
current run.

```bash
$ flight install
```

Packages get updated over time, and Flight can handle managing updates
and outdated packages. Run the following command to see what's outdated:

```bash
$ flight outdated
```

This will inform you of any formulae that have been updated to build a
version past the one you already have installed. You can now run `bundle
update PACKAGE` to upgrade just that one package, or `bundle update` to
upgrade every package. Flight uses the `brew upgrade` command to update
packages.

## Contributing

All contributions must include tests.

1. Fork it ( https://github.com/tubbo/flight/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[bundle]: http://bundler.io
[berks]: http://berkshelf.com
[brew]: http://brew.sh
