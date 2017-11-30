class Organizations::Onboarding::PoliciesController < ApplicationController
  before_action :authenticate_user!
  # before_action :allowed_onboarding_access?("FAQ")

  layout 'organizations/onboarding'

  def index
    if current_user.progress_faqs?
      current_user.update_progress("Policies")
    end

    locals ({
      user: current_user
    })
  end
end
