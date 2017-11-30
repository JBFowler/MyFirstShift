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

  def onboarding_tab(user, path_position, link_text, link_url, active=nil, custom_id=nil)
    @path ||= ["Intro", "Employee Info", "Paperwork", "FAQ", "Policies", "Applications", "First Day", "Complete"]

    if (path_position <= @path.index(user.progress)) && active.nil?
      return link_to("#{link_text} <i class='fa fa-check-circle'></i>".html_safe, link_url, class: "nav-link #{active} available", id: "#{custom_id}")
    elsif (path_position <= @path.index(user.progress)) && active
      return link_to(link_text, link_url, class: "nav-link #{active} available", id: "#{custom_id}")
    else
      return link_to(link_text, '', class: "nav-link #{active} disabled", id: "#{custom_id}")
    end
  end
end
