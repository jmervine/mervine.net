SHELL=/bin/bash

setup:
	bundle install --path vendor/bundle

start:
	RACK_ENV=$(RACK_ENV) bundle exec unicorn -D -c ./config/unicorn.rb

stop:
	kill -QUIT $$( cat ./log/unicorn.pid )

restart: stop start

cache/clean:
	rm -rf ./public/static

cache/warmup: prod/generate_error_pages
	./scripts/warmup_cache

update:
	git reset --hard
	git pull

prod/generate_error_pages:
	curl -s 'http://mervine.net/error/400'
	curl -s 'http://mervine.net/error/500'

deploy: deploy cache/cleanup restart cache/warmup

