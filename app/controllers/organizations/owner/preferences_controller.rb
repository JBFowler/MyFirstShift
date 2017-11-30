class Organizations::Owner::PreferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    locals ({
      unit_leader: current_user
    })
  end
end
