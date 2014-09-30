# Yardsale! Yardsale! Yardsale!

**Yardsale** is a simple Craiglist clone.

## Setup

### Short &amp; Sweet

Copy and paste these commands to get started.

```bash
bundle install --without production
rake setup:dotenv
ruby seed.rb
```

If you want to know more about what these are doing, read on.

### Development vs. Production Environments

Like most web applications, this project is meant to run in two different environments: development and production.  Here, "development" means your local computer and "production" means Heroku.

Inside your web application, the

```ruby
ENV['RACK_ENV']
```

environment variable will tell you which environment you're running in.  For this project, the main difference is that we use SQLite3 as our database in development but Heroku requires PostgreSQL in production.

### Install Required Gems

Remember, the `Gemfile` describes what gems are required for a project to work.  Notice how we have both a `development` and `production` group inside the `Gemfile`.  This allows us to install different gems depending on which environment our application is running in.

To install the gems required for this project, run

```bash
bundle install --without production
```

This will install every gem except those required by the "production" environment.

### Configure Your `.env` File

We use [dotenv][dotenv-wiki] in this project to manage environment-specific information.  Specifically, we need to set the `DATABASE_URL` environment variable so our application knows what database to use.  This might seem like overkill, but Heroku also sets the `DATABASE_URL` environment variable, so we'll have to use it in production regardless.

`dotenv` expects find a file named `.env`.  We've provided an `env.example` file which you can use.  From the **yardsale** root directory, run

```bash
cp env.example .env
```

or

```bash
rake setup:dotenv
```

We haven't talked much about `rake`, but the `Rakefile` defines what this command does. You can see that it's copying the `env.example` file on your behalf with

```ruby
FileUtils.cp('env.example', '.env')
```

[dotenv-wiki][https://github.com/codeunion/web-fundamentals/wiki/Glossary#dotenv]
