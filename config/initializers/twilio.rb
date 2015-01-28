require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'twilio-ruby'

# put your own credentials here
account_sid = 'ACd2540787b2e043139fdf123f84154a79'
auth_token = '0a1eb64407d1cfc6a70175d2f73e7c3a'

# set up a client to talk to the Twilio REST API
TWILIO_CLIENT = Twilio::REST::Client.new account_sid, auth_token