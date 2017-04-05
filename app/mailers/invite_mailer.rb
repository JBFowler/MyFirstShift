class InviteMailer < ApplicationMailer

  def invite_member(invite)
    @invite = invite
    @organization = invite.organization

    mail(to: invite.email, subject: "Come join #{@organization.name}'s Onboarding Group")
  end

end
