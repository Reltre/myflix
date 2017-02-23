source 'https://rubygems.org'
ruby '2.4.0'

gem 'bootstrap', '~> 4.0.0.alpha5'
gem 'sprockets-rails'
gem 'bootstrap_form'
gem 'coffee-rails'
gem 'rails', '5.0.1'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'pg'
gem 'bcrypt'
gem 'sidekiq'
gem 'unicorn'
gem 'foreman'
gem 'sentry-raven'

group :development do
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem "letter_opener"
end

group :development, :test do
  gem 'pry'
  gem 'pry-byebug'
  gem 'rspec-rails'
end

group :test do
  gem 'rails-controller-testing'
  gem 'fabrication'
  gem 'faker'
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'capybara-email'
  gem 'launchy'
end

group :production do
  gem 'rails_12factor'
end
