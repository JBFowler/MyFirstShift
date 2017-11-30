class Organizations::Onboarding::PaperworkController < ApplicationController
  before_action :authenticate_user!
  # before_action :allowed_onboarding_access?("Employee Info")

  layout 'organizations/onboarding'

  def index
    locals ({
      user: current_user
    })
  end
end
