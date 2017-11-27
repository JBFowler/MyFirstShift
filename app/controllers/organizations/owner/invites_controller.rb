class Organizations::Owner::InvitesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    invites = @organization.invites.exclude_owners

    if params[:search]
      invites = invites.where("invites.email like :email", {email: "%#{params[:search]}%"} )
    end

    if params[:sort]
      invites = invites.order(params[:sort]) unless params[:sort].blank?
    end

    pending_invites = invites.unredeemed
    accepted_invites = invites.redeemed

    locals ({
      owner: current_user,
      pending_invites: pending_invites,
      accepted_invites: accepted_invites
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
    invite = @organization.invites.exclude_owners.build(invite_params)
    invite.assign_attributes(subdomain: @organization.subdomain, expires_at: 30.days.from_now.end_of_day, role: "member", created_by: current_user)

    if invite.save
      flash[:success] = "Invitation Sent!"
      InviteMailer.invite_member(invite).deliver
      redirect_to new_owner_invite_path
    else
      render :new, locals: { owner: current_user, invite: invite }
    end
  end

  def update
    invite = @organization.invites.exclude_owners.find(params[:id])

    if invite.update(expires_at: 30.days.from_now.end_of_day)
      flash[:success] = "Invitation Sent!"
      InviteMailer.invite_member(invite).deliver
      redirect_to owner_invites_path
    else
      flash[:danger] = "There was an error resending the invite"
      redirect_to owner_invites_path
    end
  end

  def destroy
    invite = @organization.invites.find(params[:id])

    invite.delete
    redirect_to owner_invites_path
  end

  private

  def invite_params
    params.require(:invite).permit(:email)
  end
end
