class VerificationMailer < ApplicationMailer
  def send_code(user_email, user_name)
    @user_name = user_name
    mail(to: user_email, subject: 'You verification code')
  end
end
