class Organizations::Onboarding::PaperworkController < ApplicationController
  before_action :authenticate_user!
  before_action :unit_available?

  layout 'organizations/onboarding'

  def index
    locals ({
      user: current_user
    })
  end
end
