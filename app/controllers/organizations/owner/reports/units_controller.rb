class Organizations::Owner::Reports::UnitsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    units = @organization.units.with_deleted

    locals ({
      owner: current_user,
      units: units
    })
  end
end
