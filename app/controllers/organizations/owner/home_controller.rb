class Organizations::Owner::HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    members = @organization.members
    invite = Invite.new

    locals ({
      owner: current_user,
      invite: invite,
      active_users: members.active,
      ready_to_schedule: members.ready_to_schedule,
      past_twelve_months: @organization.past_years_new_members,
      eight_per_hour_members: members.eight_per_hour.count,
      ten_per_hour_members: members.ten_per_hour.count
    })
  end
end
