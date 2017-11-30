class Organizations::Onboarding::FirstDayController < ApplicationController
  before_action :authenticate_user!
  # before_action :allowed_onboarding_access?("First Day")

  layout 'organizations/onboarding'

  def index
    if current_user.progress_applications?
      current_user.update_progress("First Day")
    end

    locals ({
      user: current_user
    })
  end
end
