require "sinatra"

# We point DataMapper to the correct database in setup.rb
require "./setup"

# models.rb is where we define our Chirp model
require "./models"

require 'rack-flash'

enable :sessions
use Rack::Flash

get("/") do
  chirps = Chirp.all
  erb(:index, :locals => { :chirps => chirps })
end

get("/chirps/new") do
  chirp = Chirp.new
  erb(:chirp_new, :locals => { :chirp => chirp })
end

post("/chirps") do
  chirp = Chirp.create(params[:chirp])

  if chirp.saved?
    flash[:notice] = "New chirp created!"
    redirect("/")
  else
    flash[:errors] = chirp.errors.full_messages
    redirect("/chirps/new")
  end
end
