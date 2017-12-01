class Organizations::Owner::PreferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    first_day_items = @organization.first_day_items
    store_front = @organization.store_front

    locals ({
      owner: current_user,
      first_day_items: first_day_items,
      store_front: store_front
    })
  end
end
