class Organizations::Units::Leader::TasksController < Organizations::Units::Leader::UnitLeadBaseController
  layout 'organizations/unit_leader'

  def index
    members = @unit.members.ready_to_schedule

    locals ({
      unit_leader: current_user,
      members: members
    })
  end
end
