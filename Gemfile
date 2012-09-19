source 'http://rubygems.org'

gem 'nesta', '0.9.13'
gem 'nesta-plugin-diskcached'
gem 'nesta-plugin-google-ads'
gem 'nesta-plugin-sharethis'
#gem 'nesta-plugin-sluggable'

gem 'unicorn'

group :deploy do
  gem 'vlad'
  gem 'vlad-git'
  gem 'vlad-unicorn'
  gem 'vlad-nginx'
end

group :production do
  gem 'newrelic_rpm'
end

# gem (RUBY_VERSION =~ /^1.9/) ? 'ruby-debug19': 'ruby-debug'
