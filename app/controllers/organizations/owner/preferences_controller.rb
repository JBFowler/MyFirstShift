class Organizations::Owner::PreferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    managers = @organization.managers

    locals ({
      owner: current_user,
      managers: managers
    })
  end

  private

  def manager_params
    params.require(:manager).permit(:name, :description, :picture)
  end
end
