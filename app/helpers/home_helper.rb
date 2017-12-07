module HomeHelper
  def onboarding_percentage_complete(user)
    @path = ["Intro", "Employee Info", "Paperwork", "FAQ", "Policies", "Applications", "First Day", "Complete"]

    ((@path.index(user.progress).to_f / 7.to_f) * 100).to_i
  end

  def onboarding_button_name(progress)
    case progress
    when "Intro"
      "Begin"
    when "Complete"
      "Review"
    else
      "Continue"
    end
  end
end
