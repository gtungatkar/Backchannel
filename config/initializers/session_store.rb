# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Backchannelv3_session',
  :secret      => '364923c7bb7fdf93d6fecc2798665a3fb47efc1257ac9a12c9943758346eeb7c5695e79c11d23d8408b73184f72a257ea43364f278661a5ef16cd20a592db544'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
