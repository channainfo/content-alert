source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use mysql as the database for Active Record
gem 'mysql2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'active_model_serializers'
gem 'unicorn'

gem 'bootstrap-sass', '~> 3.3.3'
gem 'email_validator'
gem 'kaminari'
gem 'bootstrap-kaminari-views'
gem 'simple_form'
gem 'twitter-typeahead-rails'

gem 'feedjira'
gem 'sinatra', :require => nil
gem 'sidekiq'
gem 'roadie-rails'
gem 'nuntium_api'

gem 'whenever', :require => false

gem 'elasticsearch-model'
gem 'elasticsearch-rails'
gem 'elasticsearch', github: 'channainfo/elasticsearch-ruby'

group :development do
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger' #using gem passenger 4.0.58
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'pry-rails'

  gem 'faker'
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'spring-commands-rspec'

end

group :production do
  gem 'rails_12factor'
end

group :test do
  gem 'rake'
  gem "codeclimate-test-reporter", require: nil

  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'launchy'
  gem 'simplecov', require: false
end

