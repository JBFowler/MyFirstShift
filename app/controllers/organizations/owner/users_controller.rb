class Organizations::Owner::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    @owner = current_user
    @members = @organization.members
    @invite = Invite.new
  end

end
