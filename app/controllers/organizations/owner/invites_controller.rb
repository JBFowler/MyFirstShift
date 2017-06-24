class Organizations::Owner::InvitesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  def index
    @invites = @organization.invites.unscoped
  end

  def new
    @invite = Invite.new
  end

  def create
    @invite = @organization.invites.build(invite_params)
    @invite.assign_attributes(subdomain: @organization.subdomain, expires_at: @invite.expires_at.try(:end_of_day), role: "member")

    if @invite.save
      flash[:success] = "The user has been invited"
      InviteMailer.invite_member(@invite).deliver
      redirect_to owner_invites_path
    else
      render :new
    end
  end

  def destroy
    @invite = Invite.find(params[:id])

    @invite.destroy
    redirect_to owner_invites_path
  end

  private

  def invite_params
    params.require(:invite).permit(:email, :expires_at)
  end
end
