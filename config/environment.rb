# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Snapshot::Application.initialize!

Time::DATE_FORMATS[:default] = "%d/%m/%Y %l:%M%p"

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
  :address => 'mail.a-okay.net',
  :port => 25,
  :domain => 'a-okay.net',
  :authentication => :login,
  :user_name => 'myowin76@gmail.com',
  :password => 'aungmyay242'
}
