class UserMailer < PostmarkMailer::Base
  def welcome_email(user)
    @user = user
    @url  = 'http://listy.club/users/sign_in'
    mail(
      to: @user.email,
      from:'support@listy.club',
      template_id: 8043061,
      template_model: {
        username: @user.username,
        company_name: "Listy",
        product_name: "Listy",
        action_url: "http://www.listy.club/users/sign_in",
        login_url: "http://www.listy.club/users/sign_in",
        support_email: "support@listy.club",
        help_url: "help_url_Value",
        company_address: "Germany 10439 Berlin"
      }
    )
  end
end

