class Organizations::Owner::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    members = @organization.members
    ready_to_schedule = members.ready_to_schedule
    need_verification = members.need_verification

    locals ({
      owner: current_user,
      ready_to_schedule: ready_to_schedule,
      need_verification: need_verification
    })
  end
end
