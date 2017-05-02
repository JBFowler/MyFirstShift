class InviteMailerPreview < ActionMailer::Preview
  def invite_member
    InviteMailer.invite_member(Invite.first)
  end

  def invite_owner
    InviteMailer.invite_owner(Invite.first)
  end
end
