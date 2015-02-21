require "sinatra"

# We point DataMapper to the correct database in setup.rb
require "./setup"

# models.rb is where we define our Chirp model
require "./models"

# To use flash messages, we need to require the Flash middleware
require "rack-flash"

# Because flash middleware uses sessions, we need to enable sessions
set(:sessions, true)

# Make sure to use a session secret!
set(:session_secret, ENV["SESSION_SECRET"])

# Finally, to enable the `flash` method we add Rack::Flash to our middleware
use Rack::Flash

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
    flash[:notice] = "New chirp created!"
    redirect("/")
  else
    # If the chirp wasn't saved, add the error messages to flash so that the
    # user can correct their mistakes the next time around.
    flash[:errors] = chirp.errors.full_messages
    redirect("/chirps/new")
  end
end
