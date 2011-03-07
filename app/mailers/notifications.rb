class Notifications < ActionMailer::Base
  default_url_options[:host] = 'happyhourscout.com'
  default :from => 'HappyHourScout.com <noreply@happyhourscout.com>'

  def forgot_password(user)
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token)
    mail :to => user.email, :subject => "Forgot Password"
  end

end
