class Organizations::Units::Onboarding::QuestionsController < Organizations::Units::BaseController
  layout 'organizations/units/onboarding'

  def index
    if current_user.progress_paperwork?
      current_user.update_progress("FAQ")
    end

    locals ({
      user: current_user,
      faqs: get_faqs
    })
  end

  private

  def get_faqs
    if @unit.faqs.any?
      return @unit.faqs
    else
      return @organization.faqs
    end
  end
end
