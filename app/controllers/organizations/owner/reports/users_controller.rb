class Organizations::Owner::Reports::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    members = @organization.members.with_deleted

    locals ({
      owner: current_user,
      members: members
    })
  end
end
