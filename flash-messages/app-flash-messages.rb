require "sinatra"

# We point DataMapper to the correct database in setup.rb
require "./setup"

# models.rb is where we define our Chirp model
require "./models"

# In order to roll our own flash functionality, we need to use sessions.
# Sessions allow us to store values on a per-user basis, creating pseudo-state
# in an inherently stateless protocol (HTTP).
set(:sessions, true)

# A session secret is used to authenticate sessions and keep your user's
# information secure. Because this secret is critical for security, it should
# not be tracked in version control. If you used `rake setup:dotenv` you will
# see a SESSION_SECRET environment variable in the .env file.
set(:session_secret, ENV["SESSION_SECRET"])

helpers do
  # Retrieve (and delete) an item from the "flash" hash.
  #
  # Be careful how you use this! Calling it once will return the value at
  # `session[:flash][key]` AND will delete it from `session[:flash]`.
  def get_flash(key)
     session[:flash].delete(key) if session[:flash]
  end

  # Add a value to the "flash" hash.
  #
  # Store arbitrary values to be used _once_ in a subsequent request.
  def set_flash(key, value)
    session[:flash] ||= {}
    session[:flash][key] = value
  end
end

get("/") do
  chirps = Chirp.all
  erb(:index, :locals => { :chirps => chirps })
end

get("/chirps/new") do
  chirp = Chirp.new
  erb(:chirp_new)
end

post("/chirps") do
  chirp = Chirp.create(params[:chirp])

  if chirp.saved?
    # When the chirp is saved successfully, show a nice congratulatory message!
    set_flash(:notice, "New chirp created!")
    redirect("/")
  else
    # If the chirp wasn't saved, add the error messages to flash so that the
    # user can correct their mistakes the next time around.
    set_flash(:errors, chirp.errors.full_messages)
    redirect("/chirps/new")
  end
end
