class Organizations::Owner::InvitesController < ApplicationController
  before_action :authenticate_user!

  def new
    @invite = Invite.new
  end

  def create
    @invite = Invite.new(invite_params)
    @invite.assign_attributes(organization_id: @organization.id, subdomain: @organization.subdomain)

    if @invite.save
      flash[:success] = "The user has been invited"
      InviteMailer.invite_member(@invite).deliver
      redirect_to owner_home_path
    else
      render :new
    end
  end

  private

  def invite_params
    params.require(:invite).permit(:email)
  end
end
