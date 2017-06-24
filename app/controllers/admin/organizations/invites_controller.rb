class Admin::Organizations::InvitesController < Admin::BaseController
  before_action :get_organization

  def index
    @invites = Invite.unscoped.owners
  end

  def new
    @invite = Invite.new
  end

  def create
    @invite = @organization.invites.build(invite_params)
    @invite.expires_at = @invite.expires_at.end_of_day

    if @invite.save
      flash[:success] = "The invitation has been sent to the owner"
      InviteMailer.invite_owner(@invite).deliver
      redirect_to admin_organization_invites_path(@organization)
    else
      render :new
    end
  end

  def destroy
    @invite = Invite.find(params[:id])

    @invite.destroy
    redirect_to admin_organization_invites_path(@organization)
  end

  private

  def invite_params
    params.require(:invite).permit(:email, :subdomain, :expires_at, :role)
  end

  def get_organization
    @organization = Organization.unscoped.find(params[:organization_id])
  end
end
