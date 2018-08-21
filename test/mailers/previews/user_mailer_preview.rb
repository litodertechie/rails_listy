class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    user = User.first
    PostmarkMailer.welcome_email(user)
  end
end


