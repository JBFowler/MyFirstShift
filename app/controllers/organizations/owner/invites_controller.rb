class Organizations::Owner::InvitesController < ApplicationController
  before_action :authenticate_user!

  def new
    @invite = Invite.new
  end


end