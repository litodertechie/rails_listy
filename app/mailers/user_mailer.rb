class UserMailer < ApplicationMailer
  default from: 'support@listy.club'
  def welcome_email(user)
    @user = user
    @url  = 'http://listy.club/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to Listy')
  end
end
