# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Snapshot::Application.initialize!

Time::DATE_FORMATS[:default] = "%d/%m/%Y %l:%M%p"

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => 'skyron.co.uk',
  :authentication => "plain",
  :user_name => 'aung.win@skyron.co.uk',
  :password => 'mandalay7'
}