require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  handler do |job, time|
    Quote.send_to_users if job == 'quote.job'
  end

  every(1.hour, 'quote.job', :at => '*:00')
end