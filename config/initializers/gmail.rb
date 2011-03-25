require 'tlsmail'
Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true

ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,  #this is the important shit!
  :address        => 'smtp.gmail.com',
  :port           => 587,
  :domain         => '11happyhourscout.com',
  :authentication => :plain,
  :user_name      => 'noreply@111.com',
  :password       => 'password'
}