# At the database level we store three things:
#   1. The auto-generated user ID
#   2. The user's email, which must be unique
#   3. A hashed copy of the user's password
class User
  include DataMapper::Resource

  property :id, Serial

  property :email, String,
    :format   => :email_address,
    :required => true,
    :unique   => true,
    :messages => {
      :format => "You must enter a valid email address."
    }

  property :password, BCryptHash, :required => true
  validates_confirmation_of :password

  # Due to the way DataMapper works, we have to add the length
  #   validation to the confirmation field.
  attr_accessor :password_confirmation
  validates_length_of :password_confirmation, :min => 6


  # Retrieves a user from the database based on credentials.
  # Adds errors to user.errors.
  # @param email <String> Email to look up
  # @param password <String> Password
  # @return <User>
  def self.find_by_credentials(email, password)
    user = find_by_email(email)
    # If the user already has an error, adding the password errors is confusing.
    user.validate_password!(password) if user.errors.empty?
    user
  end

  # Finds a user by email address.
  # Adds  user.errors[:general] When email cannot be found.
  # @param email <String> email to find from database
  # @return <User>
  def self.find_by_email(email)
    # Try to retrieve a user, otherwise create a new one (but don't save it!)
    user = self.first(:email => email) || self.new({ email: email })
    # Return the user we found, but move on if it's a new user.
    return user if user.saved?

    # Add an error saying we couldn't find a user!
    user.errors.add(:general, "We couldn't find someone with that email and password. Could you double-check what you put in?")
    # return the new user.
    user
  end

  # Checks if a given matches the password stored in the database.
  # Adds an error if not to user.errors[:password] if they do not match.
  # @param unhashed_password <String> Password to compare against database
  # @return <Boolean>
  def validate_password!(unhashed_password)
    # Note: BCryptHash "overloads" the == operator, so we're actually
    #   comparing a BCrypt-hashed copy of unhashed_password to the hashed
    #   copy stored in our database.

    if self.password == unhashed_password
      true
    else
      self.errors.add(:password, "The password entered doesn't match our records for that user.")
      false
    end
  end
end

DataMapper.finalize()
DataMapper.auto_upgrade!()
