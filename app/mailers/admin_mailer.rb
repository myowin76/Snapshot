class AdminMailer < ActionMailer::Base
  default from: "notification@skyron.co.uk"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.loginpage_message.subject
  #
  def loginpage_message params
    
    @greeting = "Hello Admin"
    @email = params['email']
    @msg = params['message']
    mail(to: "aung.win@skyron.co.uk",
         from: @email,
         subject: "Message from Login page") do |format|
        format.text
        # format.html{ render :layout => false }
        
    end  

  end
end
