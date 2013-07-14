SHELL=/bin/bash
RACK_ENV?=production
NGINX_ETC=/usr/local/etc/nginx
NGINX_INIT=/etc/init.d/nginxps

setup:
	bundle install --path vendor/bundle

run:
	RACK_ENV=$(RACK_ENV) bundle exec rackup -p 3000 ./config.ru

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

prod/generate_error_pages:
	curl -s 'http://mervine.net/error/400'
	curl -s 'http://mervine.net/error/500'

deploy/soft: update cache/clean prod/generate_error_pages

deploy: update cache/clean restart prod/generate_error_pages

deploy/full: update cache/clean restart nginx/reload prod/generate_error_pages

# nginx handlers
nginx/start:
	sudo $(NGINX_INIT) start

nginx/stop:
	sudo $(NGINX_INIT) start

nginx/restart:
	sudo $(NGINX_INIT) restart

nginx/status:
	$(NGINX_INIT) status

nginx/reload: nginx/update_configs
	sudo $(NGINX_INIT) reload

nginx/update_configs:
	@sudo cp -v $(NGINX_ETC)/nginx.conf $(NGINX_ETC)/nginx.conf.bak
	@sudo cp -v ./config/nginx.conf $(NGINX_ETC)/nginx.conf
	@sudo cp -v $(NGINX_ETC)/sites-available/mervine.net $(NGINX_ETC)/sites-available/mervine.net.bak
	@sudo cp -v ./config/mervine.net.conf $(NGINX_ETC)/sites-available/mervine.net
