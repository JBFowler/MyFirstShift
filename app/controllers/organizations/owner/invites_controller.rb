class Organizations::Owner::InvitesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    invites = @organization.invites.unscoped

    locals ({
      owner: current_user,
      invites: invites
    })
  end

  def new
    invite = Invite.new

    locals ({
      owner: current_user,
      invite: invite
    })
  end

  def create
    invite = @organization.invites.build(invite_params)
    invite.assign_attributes(subdomain: @organization.subdomain, expires_at: 30.days.from_now.end_of_day, role: "member")

    if invite.save
      flash[:success] = "Invitation Sent!"
      InviteMailer.invite_member(invite).deliver
      redirect_to new_owner_invite_path
    else
      render :new, locals: { owner: current_user, invite: invite }
    end
  end

  def destroy
    invite = Invite.find(params[:id])

    invite.destroy
    redirect_to owner_invites_path
  end

  private

  def invite_params
    params.require(:invite).permit(:email)
  end
end
