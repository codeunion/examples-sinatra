## Set up CarrierWave for AWS
CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = ENV.fetch("AWS_S3_BUCKET_NAME")
  config.aws_acl    = :public_read
  config.asset_host = ENV.fetch("ASSET_HOST")
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

  config.aws_credentials = {
    :access_key_id     => ENV.fetch("AWS_ACCESS_KEY_ID"),
    :secret_access_key => ENV.fetch("AWS_SECRET_ACCESS_KEY")
  }
end

## Set up our database connection with DataMapper

# Display DataMapper debugging information in development
if Sinatra::Application.development?
  DataMapper::Logger.new($stdout, :debug)
end

# Connect to the database.
DataMapper.setup(:default, ENV.fetch("DATABASE_URL"))

# Require all .rb files in the models/ directory.
Dir[File.join(Sinatra::Application.root, "models", "*.rb")].each do |model_file|
  require model_file
end

# Tell DataMapper we're done defining models
DataMapper.finalize()

# Tell DataMapper to make any necessary changes to the database, e.g.,
# create tables, add fields, modify fields, etc.
DataMapper.auto_upgrade!()
