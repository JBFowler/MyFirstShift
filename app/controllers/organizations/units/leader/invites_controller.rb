class Organizations::Units::Leader::InvitesController < Organizations::Units::Leader::UnitLeadBaseController
  layout 'organizations/unit_leader'

  def index
    invites = @unit.invites

    if params[:search]
      invites = invites.where("invites.email like :email", {email: "%#{params[:search]}%"} )
    end

    if params[:sort]
      invites = invites.order(params[:sort]) unless params[:sort].blank?
    end

    pending_invites = invites.unredeemed
    accepted_invites = invites.redeemed

    locals ({
      unit_leader: current_user,
      pending_invites: pending_invites,
      accepted_invites: accepted_invites
    })
  end

  def new
    invite = Invite.new

    locals ({
      unit_leader: current_user,
      invite: invite
    })
  end

  def create
    invite = @unit.invites.build(invite_params)
    invite.assign_attributes(organization: @organization, subdomain: @organization.subdomain, expires_at: 30.days.from_now.end_of_day, role: "member", created_by: current_user)

    if invite.save
      flash[:success] = "Invitation Sent!"
      InviteMailer.invite_member(invite).deliver
      redirect_to new_unit_leader_invite_path(@unit)
    else
      render :new, locals: { unit_leader: current_user, invite: invite }
    end
  end

  def update
    invite = @unit.invites.find(params[:id])

    if invite.update(expires_at: 30.days.from_now.end_of_day)
      flash[:success] = "Invitation Sent!"
      InviteMailer.invite_member(invite).deliver
      redirect_to unit_leader_invites_path(@unit)
    else
      flash[:danger] = "There was an error resending the invite"
      redirect_to unit_leader_invites_path(@unit)
    end
  end

  def destroy
    invite = @unit.invites.find(params[:id])

    invite.delete
    redirect_to unit_leader_invites_path(@unit)
  end

  private

  def invite_params
    params.require(:invite).permit(:email)
  end
end
