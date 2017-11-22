source 'https://rubygems.org'
ruby '2.4.1'

gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'sprockets-rails'
gem 'bootstrap_form'
gem 'coffee-rails'
gem 'rails', '5.1.1'
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
gem 'mini_magick'
gem 'carrierwave-aws'
gem 'stripe'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end

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

  gem 'fabrication'
  gem 'faker'
  gem 'capybara'
  gem 'database_cleaner'

  gem 'shoulda-matchers', '~> 3.1'
  gem 'selenium-webdriver'
  gem 'capybara-webkit'
  gem 'capybara-email'
  gem 'launchy'
  # gem 'poltergeist'
  gem 'rails-controller-testing'
end

group :production do
  gem 'rails_12factor'
end
