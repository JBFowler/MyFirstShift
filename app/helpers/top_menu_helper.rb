require 'pry'
module TopMenuHelper
  def current_tab?(controller, action="index")
    case
    when controller?("organizations/onboarding/#{controller}") && action?(action)
      "active"
    else
      ""
    end
  end
end
