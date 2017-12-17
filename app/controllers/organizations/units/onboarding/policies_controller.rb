class Organizations::Units::Onboarding::PoliciesController < Organizations::Units::BaseController
  layout 'organizations/units/onboarding'

  def index
    if current_user.progress_faqs?
      current_user.update_progress("Policies")
    end

    locals ({
      user: current_user,
      policies: get_policies
    })
  end

  private

  def get_policies
    if @unit.policies.any?
      return @unit.policies
    else
      return @organization.policies
    end
  end
end
