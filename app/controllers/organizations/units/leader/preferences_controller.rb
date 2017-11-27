class Organizations::Units::Leader::PreferencesController < Organizations::Units::Leader::UnitLeadBaseController
  layout 'organizations/unit_leader'

  def index
    managers = @unit.managers

    locals ({
      unit_leader: current_user,
      managers: managers
    })
  end

  private

  def manager_params
    params.require(:manager).permit(:name, :description, :picture)
  end
end
