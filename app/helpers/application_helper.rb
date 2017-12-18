module ApplicationHelper
  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def onboarding_current_path(progress)
    case progress
    when "Intro"
      onboarding_meet_the_management_path
    when "Employee Info"
      onboarding_employee_info_path
    when "Paperwork"
      onboarding_paperwork_path
    when "FAQ"
      onboarding_questions_path
    when "Policies"
      onboarding_policies_path
    when "Applications"
      onboarding_apps_path
    when "First Day"
      onboarding_first_day_path
    else
      onboarding_meet_the_management_path
    end
  end

  def unit_onboarding_current_path(progress, unit)
    case progress
    when "Intro"
      unit_onboarding_meet_the_management_path(unit)
    when "Employee Info"
      unit_onboarding_employee_info_path(unit)
    when "Paperwork"
      unit_onboarding_paperwork_path(unit)
    when "FAQ"
      unit_onboarding_questions_path(unit)
    when "Policies"
      unit_onboarding_policies_path(unit)
    when "Applications"
      unit_onboarding_apps_path(unit)
    when "First Day"
      unit_onboarding_first_day_path(unit)
    else
      unit_onboarding_meet_the_management_path(unit)
    end
  end
end
