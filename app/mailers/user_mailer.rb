class UserMailer < ActionMailer::Base
  default from: "aung.win@skyron.co.uk"

  def registration_confirmation user
  	recipients 	user.email
  	subject			"Thank you for Registering"
  	body				:user => user
  end

  def welcome_mail
  	
  end


end
