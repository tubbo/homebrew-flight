.PHONY: all share/man/man.1/flight.1 man build install

all: man build

test:
	bundle exec rspec

share/man/man.1/flight.1:
	kramdown-man doc/man/flight.md share/man/man.1/flight.1

man: share/man/man.1/flight.1

dependencies:
	bundle install --path=${PREFIX}/vendor/bundle --deployment

build: dependencies
	bundle exec rake build

install: build
	sudo gem install ${PREFIX}/pkg/*.gem
