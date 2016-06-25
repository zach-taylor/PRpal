source 'https://rubygems.org'

ruby '2.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.0.0.rc1'
# Postgres
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '~> 5.x'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'attr_extras'
gem 'net_tcp_client'
gem 'octokit'
gem 'omniauth-github'
gem 'rails_semantic_logger'
gem 'rollbar'
gem 'semantic-ui-sass'
gem 'sidekiq'
gem 'sinatra', github: 'sinatra/sinatra', require: false
gem 'skylight'

# Trailblazer
gem 'trailblazer-rails'
gem 'trailblazer-cells'
gem 'cells-rails'
gem 'cells-slim'
gem 'reform-rails'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  gem 'rubocop'
end

group :development do
  gem 'foreman'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # gem 'ci_reporter_minitest'
  gem 'minitest-rails-capybara', github: 'blowmage/minitest-rails-capybara'
  gem 'minitest-spec-rails'
  #gem 'capybara_minitest_spec'
  gem 'capybara'
  gem 'mocha'
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
