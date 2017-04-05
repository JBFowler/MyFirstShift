class InviteMailerPreview < ActionMailer::Preview
  def invite_member
    InviteMailer.invite_member(Invite.first)
  end
end