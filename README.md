# Flight

Flight helps manage your Homebrew packages in the same way
[Bundler][bundler] helps you manage gem dependencies. With your
`Brewfile`, you can tell Homebrew to install packages, configure build
options, and even install custom taps.

## Installation

The best way is to install with Homebrew, using my Homebrew tap. Install
the tap by running the following command:

```bash
$ brew tap tubbo/homebrew-tap
```

Now, all you have to do to install flight is:

```bash
$ brew install flight
$ flight --version
Flight v0.0.1
```

You can also include it as a dependency in your Ruby project with
Bundler. Just add this line to Gemfile and run `bundle`:

```ruby
gem 'flight'
```

Or, you can install it as a RubyGem with:

```bash
$ gem install flight
```

## Usage

First of all, you'll need a Brewfile before you do anything else.
Generate one with the following command:

```bash
$ flight generate
```

Next, edit the Brewfile with the packages you want to install. You can
specify version constraints in the same manner as Bundler and
Berkshelf.

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

1. Fork it ( https://github.com/[my-github-username]/flight/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
