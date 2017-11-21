class Organizations::Units::Leader::HomeController < Organizations::Units::Leader::UnitLeadBaseController
  layout 'organizations/unit_leader'

  def index
    members = @unit.members

    locals ({
      unit_leader: current_user,
      active_users: members.active,
      ready_to_schedule: members.ready_to_schedule,
      past_twelve_months: @unit.past_years_new_members,
      eight_per_hour_members: members.eight_per_hour.count,
      ten_per_hour_members: members.ten_per_hour.count
    })
  end
end
