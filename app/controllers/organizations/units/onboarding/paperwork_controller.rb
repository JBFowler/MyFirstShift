class Organizations::Units::Onboarding::PaperworkController < Organizations::Units::BaseController
  layout 'organizations/units/onboarding'

  def index
    locals ({
      user: current_user
    })
  end
end
