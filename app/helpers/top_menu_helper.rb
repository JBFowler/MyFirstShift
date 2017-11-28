module TopMenuHelper
  def current_onboarding_tab?(controller, action="index")
    case
    when controller?("organizations/onboarding/#{controller}") && action?(action)
      "active"
    else
      nil
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

  def onboarding_tab(user, path_position, link_text, link_url, active=nil)
    @path ||= ["Intro", "Employee Info", "Paperwork", "FAQ", "Policies", "Applications", "First Day", "Complete"]

    if path_position <= @path.index(user.progress)
      return link_to(link_text, link_url, class: "nav-link #{active} available")
    else
      return link_to(link_text, '', class: "nav-link #{active} disabled")
    end
  end
end
