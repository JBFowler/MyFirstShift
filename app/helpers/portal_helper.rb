module PortalHelper
  def display_unit(user)
    if user.unit.nil?
      return "None #{link_to 'Add to Unit', '', data: { toggle: 'modal', target: '#unitListModal' }, class: 'pull-right'}".html_safe
    else
      return "#{link_to user.unit.name, owner_unit_path(user.unit)} #{link_to 'Switch Unit', '', data: { toggle: 'modal', target: '#unitListModal' }, class: 'pull-right'}".html_safe
    end
  end

  def hourly_pay_percentage(hourly_pay, eight_members, ten_members)
    total ||= eight_members + ten_members
    return 0 unless total > 0

    case hourly_pay
    when 8
      ((eight_members.to_f / total.to_f) * 100).round
    when 10
      ((ten_members.to_f / total.to_f) * 100).round
    end
  end

  def total_hourly_pay_percentage(eight_members, ten_members)
    hourly_pay_percentage(8, eight_members, ten_members) + hourly_pay_percentage(10, eight_members, ten_members)
  end

  def wage_presenter(user)
    case user.employee_type
    when "salary"
      return "#{number_to_currency(user.wage)}/yr"
    when "hourly"
      return "#{number_to_currency(user.wage)}/hr"
    end
  end
end
