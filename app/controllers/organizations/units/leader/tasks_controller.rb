class Organizations::Units::Leader::TasksController < Organizations::Units::Leader::UnitLeadBaseController
  layout 'organizations/unit_leader'

  def index
    members = @unit.members
    ready_to_schedule = members.ready_to_schedule
    need_verification = members.need_verification

    locals ({
      unit_leader: current_user,
      ready_to_schedule: ready_to_schedule,
      need_verification: need_verification
    })
  end
end
