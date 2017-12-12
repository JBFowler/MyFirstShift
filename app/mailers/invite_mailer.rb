class InviteMailer < ApplicationMailer

  def invite_member(invite)
    @invite = invite
    @organization = invite.organization

    mail(to: invite.email, subject: "Join #{@organization.name}'s Onboarding Group")
  end

  def invite_owner(invite)
    @invite = invite
    @organization = invite.organization

    mail(to: invite.email, subject: "Set up your account for #{@organization.name}'s Onboarding Group")
  end

end
