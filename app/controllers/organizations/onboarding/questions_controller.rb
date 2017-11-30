class Organizations::Onboarding::QuestionsController < ApplicationController
  before_action :authenticate_user!
  # before_action :allowed_onboarding_access?("Paperwork")

  layout 'organizations/onboarding'

  def index
    if current_user.progress_paperwork?
      current_user.update_progress("FAQ")
    end

    locals ({
      user: current_user,
      faqs: @organization.faqs
    })
  end
end
