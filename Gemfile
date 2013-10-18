source 'http://rubygems.org'

gem 'rake'
gem 'nesta'

gem 'ferret'
gem 'mime-types'

gem 'nesta-plugin-google-ads'
gem 'nesta-plugin-sharethis'
gem 'nesta-plugin-smartmeta'
gem 'nesta-plugin-search'

#gem 'nesta-plugin-diskcached'

#gem 'coderay'
gem "ultraviolet", :require => "uv"
gem 'rack-codehighlighter', :require => 'rack/codehighlighter'
gem 'htmlcompressor'
gem 'unicorn'

group :production do
  gem 'newrelic_rpm', :require => false
  gem 'rack-hard-copy'
end

group :test do
  gem 'rack-test'
end

group :development do
  gem 'shotgun'
  gem 'pry'
  gem 'pry-doc'
end
# gem (RUBY_VERSION =~ /^1.9/) ? 'ruby-debug19': 'ruby-debug'
