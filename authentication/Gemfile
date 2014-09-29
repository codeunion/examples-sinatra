source "https://rubygems.org"

gem "sinatra"
gem "data_mapper"
gem "bcrypt"

group :development do
  # We use SQLite3 on our local machines
  gem "sqlite3"
  gem "dm-sqlite-adapter"

  gem "dotenv"
  gem "rerun"
end

group :production do
  # We use PostgreSQL on Heroku, not SQLite3
  gem "pg"
  gem "dm-postgres-adapter"
end
