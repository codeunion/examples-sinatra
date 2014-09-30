## Set up CarrierWave

CarrierWave.configure do |config|
  config.permissions           = 0666  # Make uploads world-readable + writable
  config.directory_permissions = 0777  # Make directories world-read + write
  config.storage               = :file # Use file-based uploads

  # Use "tmp" directory to process uploads (e.g., resize)
  config.cache_dir = "#{Sinatra::Application.root}/tmp"
end

## Set up our database connection with DataMapper

# Display DataMapper debugging information in development
if Sinatra::Application.development?
  DataMapper::Logger.new($stdout, :debug)
end

# Connect to the database.
DataMapper.setup(:default, ENV["DATABASE_URL"])

# Require all .rb files in the models/ directory.
Dir[File.join(Sinatra::Application.root, "models", "*.rb")].each do |model_file|
  require model_file
end

DataMapper.finalize()
DataMapper.auto_upgrade!()
