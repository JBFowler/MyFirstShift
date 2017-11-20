class Organizations::Units::Leader::Reports::UsersController < Organizations::Units::Leader::UnitLeadBaseController
  layout 'organizations/unit-leader'

  def index
    members = @unit.members.with_deleted

    locals ({
      unit_leader: current_user,
      members: members
    })
  end
end
