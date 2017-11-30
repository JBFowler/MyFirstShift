class Organizations::Units::Leader::PreferencesController < Organizations::Units::Leader::UnitLeadBaseController
  layout 'organizations/unit_leader'

  def index
    locals ({
      owner: current_user
    })
  end
end
