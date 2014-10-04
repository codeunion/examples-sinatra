require "sinatra"

# We point DataMapper to the correct database in setup.rb
require "./setup"

# models.rb is where we define our User model
require "./models"

# This defines all the methods below as "helpers", which
#   makes them available both here and in our views.
helpers do
  def current_user
    # Return nil if no user is logged in
    return nil unless session.key?(:user_id)

    # If @current_user is undefined, define it by
    # fetching it from the database.
    @current_user ||= User.get(session[:user_id])
  end

  def user_signed_in?
    # A user is signed in if the current_user method
    # returns something other than nil
    !current_user.nil?
  end

  def sign_in!(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def sign_out!
    @current_user = nil
    session.delete(:user_id)
  end
end

set(:sessions, true)
set(:session_secret, ENV["SESSION_SECRET"])

get("/") do
  users = User.all
  erb(:index, :locals => { :users => users })
end

get("/users/new") do
  user = User.new
  erb(:users_new, :locals => { :user => user })
end

post("/users") do
  user = User.create(params[:user])

  if user.saved?
    sign_in!(user)

    redirect("/")
  else
    erb(:users_new, :locals => { :user => user })
  end
end

get("/sessions/new") do
  user = User.new
  erb(:sessions_new, :locals => { :user => user })
end

post("/sessions") do
  user = User.find_by_email(params[:email])

  if user && user.valid_password?(params[:password])
    sign_in!(user)
    redirect("/")
  else
    erb(:sessions_new, :locals => { :user => user })
  end
end

get("/sessions/sign_out") do
  sign_out!
  redirect("/")
end
