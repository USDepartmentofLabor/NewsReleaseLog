source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Specifying the ruby version to make sure it stays consistent through out the application
ruby "2.6.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6'

# A Ruby/Rack web server built for concurrency
gem 'puma', '~> 3.12'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Mongoid is an ODM (Object-Document-Mapper) framework for MongoDB in Ruby.
gem 'mongoid', '6.2.1'

# Frontend web framework for styling
gem 'bootstrap', '4.3.1'

# A Rails form builder plugin with semantically rich and accessible markup.
gem 'formtastic', '3.1.5'

# font-awesome-rails provides the Font-Awesome web fonts and stylesheets as a Rails engine for use with the asset pipeline.
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.3'

# Addition dependency for bootstrap
gem 'jquery-rails', '4.3.5'

# JQuery UI Datepicker
gem 'jquery-ui-rails'

# Flexible authentication solution for Rails with Warden.
gem 'devise', '4.7.1'

# Minimal authorization through OO design and pure Ruby classes
gem 'pundit', '1.1.0'

# AASM - State machines for Ruby classes (plain Ruby, ActiveRecord, Mongoid)
gem 'aasm', '4.12.3'

# A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for Ruby webapps
gem 'kaminari', '1.1.1'
gem 'kaminari-mongoid', '1.0.1'
gem 'kaminari-actionview', '1.1.1'

# Multi-user non-linear history tracking, auditing, undo, redo for mongoid.
gem 'mongoid-history', '0.8.1'

# Enumerated attributes with I18n and ActiveRecord/Mongoid support
gem 'enumerize', '2.2.2'

# Classier solution for file uploads for Rails, Sinatra and other Ruby web frameworks
gem 'carrierwave', '1.2.3'
# Mongoid support for CarrierWave
gem 'carrierwave-mongoid', '1.1.0', :require => 'carrierwave/mongoid'

# The Spreadsheet Library is designed to read and write Spreadsheet Documents. Spreadsheet can read, write and modify Spreadsheet Documents.
gem 'spreadsheet', '1.2.2'

gem 'nokogiri', '~>1.11.4'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '10.0.2', platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails", '3.7.2'
  gem 'mongoid-rspec', '4.0.1'
  gem 'factory_bot_rails', '4.10.0'
  gem "database_cleaner", '1.7.0'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
