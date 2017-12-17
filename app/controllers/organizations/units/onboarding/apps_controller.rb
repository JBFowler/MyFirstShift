class Organizations::Units::Onboarding::AppsController < Organizations::Units::BaseController
  layout 'organizations/units/onboarding'

  def index
    if current_user.progress_policies?
      current_user.update_progress("Applications")
    end

    locals ({
      user: current_user
    })
  end
end
