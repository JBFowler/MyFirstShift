module TopMenuHelper
  def current_tab?(controller, action="index")
    case
    when controller?("organizations/onboarding/#{controller}") && action?(action)
      "active"
    else
      ""
    end
  end

  def current_owner_tab?(controller, action="index")
    case
    when controller?("organizations/owner/#{controller}") && action?(action)
      "active"
    else
      ""
    end
  end
end
