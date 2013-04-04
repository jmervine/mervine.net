source 'http://rubygems.org'

gem 'rake'
gem 'nesta', '~> 0.9.13'

gem 'ferret'

gem 'nesta-plugin-google-ads'
gem 'nesta-plugin-sharethis'
gem 'nesta-plugin-smartmeta'
gem 'nesta-plugin-search'

#gem 'coderay'
gem "ultraviolet", :require => "uv"
gem 'rack-codehighlighter', :require => 'rack/codehighlighter'
gem 'unicorn'

group :production do
  gem 'newrelic_rpm', :require => false
  #gem 'nesta-plugin-diskcached'
end

group :test do
  gem 'rack-test'
end

group :development do
  gem 'pry'
  gem 'pry-doc'
end
# gem (RUBY_VERSION =~ /^1.9/) ? 'ruby-debug19': 'ruby-debug'
