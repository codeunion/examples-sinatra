require "sinatra"

# The code below will automatically require all the gems listed in our Gemfile,
# so we don't have to manually require gems a la
#
#   require 'data_mapper'
#   require 'dotenv'
#
# See: http://bundler.io/sinatra.html

require "rubygems"
require "bundler/setup"

# Bundler.require(...) requires all gems necessary regardless of
#   environment (:default) in addition to all environment-specific gems.
Bundler.require(:default, Sinatra::Application.environment)

# NOTE:
#   Sinatra::Application.environment is set to the value of ENV['RACK_ENV']
#   if RACK_ENV is set.  Otherwise, it defaults to :development.

# Load the .env file if it exists
if File.exist?(".env")
  Dotenv.load(".env")
end

# Yell at the user (and exit) if DATABASE_URL isn't set
unless ENV.key?("DATABASE_URL")
  puts "ENV['DATABASE_URL'] is undefined.  Make sure your .env file is correct."
  puts "To use the example file env.example, run"
  puts ""
  puts "  rake setup:dotenv"
  puts ""
  exit 1
end

# In development, the DATABASE_URL environment variable should be defined in
#   the '.env' file. In production, Heroku will set this environment variable
#   for you.
DataMapper.setup(:default, ENV["DATABASE_URL"])

# Display DataMapper debugging information in development
if Sinatra::Application.development?
  DataMapper::Logger.new($stdout, :debug)
end
