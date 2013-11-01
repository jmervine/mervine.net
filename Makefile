SHELL=/bin/bash
RACK_ENV?=production
NGINX_ETC=/usr/local/nginx/conf
NGINX_INIT=/etc/init.d/nginx

setup:
	bundle install --path vendor/bundle

run:
	RACK_ENV=develop bundle exec rackup -p 3000 ./config.ru

start:
	RACK_ENV=$(RACK_ENV) bundle exec unicorn -D -c ./config/unicorn.rb

stop:
	kill -QUIT $$( cat ./log/unicorn.pid )

restart: stop start

clean: purge
	rm -rf ./public/static

cache: generate_error_pages
	/home/jmervine/ocp/ocp -l /home/jmervine/mervine.net/public/static -v http://mervine.net/sitemap.xml

purge:
	-bundle exec ./scripts/purge.rb

update:
	git reset --hard
	git pull

generate_error_pages:
	curl -s 'http://mervine.net/error/400'
	curl -s 'http://mervine.net/error/500'

deploy/soft: update clean generate_error_pages cache

deploy: update clean restart generate_error_pages cache

deploy/full: update clean restart nginx/reload generate_error_pages cache

# nginx handlers
nginx/start:
	sudo $(NGINX_INIT) start

nginx/stop:
	sudo $(NGINX_INIT) stop

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
