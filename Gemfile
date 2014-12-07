source 'https://rubygems.org'
ruby '2.1.2'

gem 'rails', '4.2.0.beta2'
gem 'rails-api'
gem 'jbuilder'
gem 'pg'
gem 'bcrypt'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
gem 'rack-cors', require: 'rack/cors'
gem 'validates_email_format_of'
gem 'responders', '~> 2.0'
gem 'arel', '6.0.0.beta2' # Fixes issue with scaffold - http://stackoverflow.com/questions/27139007/cant-migrate-database-after-scaffold-section-2-2-ruby-on-rails-tutorial-michae

gem 'rails_12factor', group: :production


group :development do
  gem 'bullet'
  gem 'guard'
  gem 'guard-rspec'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'faker'
  gem 'spring'
  gem 'shoulda-matchers', require: false
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'dotenv-rails'
  gem 'rspec-activemodel-mocks'
end
