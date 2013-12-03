# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
UnicornNginx::Application.config.secret_key_base = '20afccd76500525470622f82aaa8303b097a9c861f454ce1b8b2cac7e704ddb0888555f85039edde02373162e4a1777400060f083d876d01c80090f44efc94c8'
