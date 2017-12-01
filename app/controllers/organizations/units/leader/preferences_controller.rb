class Organizations::Units::Leader::PreferencesController < Organizations::Units::Leader::UnitLeadBaseController
  layout 'organizations/unit_leader'

  def index
    first_day_items = @unit.first_day_items
    store_front = @unit.store_front

    locals ({
      unit_leader: current_user,
      first_day_items: first_day_items,
      store_front: store_front
    })
  end
end
