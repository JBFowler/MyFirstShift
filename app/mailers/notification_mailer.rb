class NotificationMailer < ApplicationMailer

  def notify(email, users, invites)
    @invites = invites
    @users = users
    @email = email

    mail(to: @email, subject: "Your Organizations")
  end

end
