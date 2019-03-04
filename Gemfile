source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'
gem 'rails', '~> 5.2.1'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '~> 3.11'
gem 'simple_form', '~> 4.0', '>= 4.0.1'
gem 'sass-rails', '~> 5.0'
gem "cancancan"
gem 'mini_magick'
gem 'carrierwave', '~> 1.3', '>= 1.3.1'
gem 'uglifier', '>= 1.3.0'
gem 'fog-aws', '~> 3.3'
gem 'bootstrap-material-design', '~> 0.2.2'
gem 'popper_js', '~> 1.9', '>= 1.9.9'
gem 'faker', '~> 1.9', '>= 1.9.1'
gem 'Platform', '~> 0.4.1'
gem 'rails_admin', '~> 1.4', '>= 1.4.2'
gem 'jquery-rails', '~> 4.3', '>= 4.3.3'
gem 'rails-ujs', '~> 0.1.0'
gem 'devise', '~> 4.5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'lograge'
gem 'ransack'
gem 'kaminari'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'awesome_print'
  gem 'meta_request'
  gem 'rubocop', require: false
  gem 'rails_best_practices'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'wrappers', '~> 0.0.1'
  gem "capistrano"
  gem "capistrano3-puma"
  gem "capistrano-rails", require: false
  gem "capistrano-bundler", require: false
  gem "capistrano-rvm"
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
