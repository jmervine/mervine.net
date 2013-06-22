SHELL=/bin/bash
RACK_ENV=production

setup:
	bundle install --path vendor/bundle

start:
	RACK_ENV=$(RACK_ENV) bundle exec unicorn -D -c ./config/unicorn.rb

stop:
	kill -QUIT $$( cat ./log/unicorn.pid )

restart: stop start

clean: cache/clean

cache/clean:
	rm -rf ./public/static

cache/warmup: prod/generate_error_pages
	./scripts/warmup_cache

update:
	git reset --hard
	git pull
	sudo cp ./config/nginx.conf /etc/nginx/sites-available/mervine.net


prod/generate_error_pages:
	curl -s 'http://mervine.net/error/400'
	curl -s 'http://mervine.net/error/500'

deploy: update cache/clean restart cache/warmup

# nginx handlers
nginx/start:
	sudo /etc/init.d/nginx start

nginx/stop:
	sudo /etc/init.d/nginx start

nginx/restart:
	sudo /etc/init.d/nginx restart

nginx/reload:
	sudo /etc/init.d/nginx reload

nginx/status:
	sudo /etc/init.d/nginx status

