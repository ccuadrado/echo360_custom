# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_echo360_custom_session',
  :secret      => '575634bae355a35885dede7ae48a714f07cfe56fd95e6c8135938ad50f2ddef023aa28fc8c27dbfa037f45c952e9282fb877336e94d9e5f54e05e09d09c07907'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
