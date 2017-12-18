class Organizations::Onboarding::AppsController < ApplicationController
  before_action :authenticate_user!
  before_action :unit_available?

  layout 'organizations/onboarding'

  def index
    if current_user.progress_policies?
      current_user.update_progress("Applications")
    end

    locals ({
      user: current_user
    })
  end
end
