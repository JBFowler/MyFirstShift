class Organizations::Owner::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    members = @organization.members.ready_to_schedule

    locals ({
      owner: current_user,
      members: members
    })
  end
end
