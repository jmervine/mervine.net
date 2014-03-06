SHELL=/bin/bash
RACK_ENV?=production
NGINX_ETC=/usr/local/nginx/conf
NGINX_INIT=/etc/init.d/nginx
DOMAIN=mervine.net

setup:
	bundle install --path vendor/bundle

run:
	RACK_ENV=develop bundle exec rackup -p 3000 ./config.ru

start:
	RACK_ENV=$(RACK_ENV) bundle exec unicorn -D -c ./config/unicorn.rb

stop:
	kill -QUIT $$( cat ./log/unicorn.pid )

restart: stop start

clean:
	rm -rf ./public/static

sitemap:
	rm -rf ./public/static/sitemap.xml || true
	curl -s --output /dev/null http://$(DOMAIN)/sitemap.xml

cache: sitemap generate_error_pages
	/home/jmervine/ocp/ocp -l /home/jmervine/$(DOMAIN)/public/static -v http://$(DOMAIN)/sitemap.xml

purge:
	-bundle exec ./scripts/purge.rb

update:
	git reset --hard
	git pull

generate_error_pages:
	curl -s --output /dev/null 'http://$(DOMAIN)/error/400'
	curl -s --output /dev/null 'http://$(DOMAIN)/error/500'

deploy/soft: update clean generate_error_pages cache

deploy: update clean restart generate_error_pages cache

deploy/full: update purge clean restart nginx/reload generate_error_pages cache

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
	@sudo cp -v $(NGINX_ETC)/sites-available/$(DOMAIN) $(NGINX_ETC)/sites-available/$(DOMAIN).bak
	@sudo cp -v ./config/$(DOMAIN).conf $(NGINX_ETC)/sites-available/$(DOMAIN)

