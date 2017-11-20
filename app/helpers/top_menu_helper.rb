module TopMenuHelper
  def current_tab?(controller, action="index")
    case
    when controller?("organizations/onboarding/#{controller}") && action?(action)
      "active"
    else
      ""
    end
  end

  def current_owner_tab?(controller)
    case
    when controller?("organizations/owner/#{controller}")
      "active"
    else
      ""
    end
  end

  def current_unit_leader_tab?(controller)
    case
    when controller?("organizations/units/leader/#{controller}")
      "active"
    else
      ""
    end
  end
end
