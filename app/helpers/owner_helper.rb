module OwnerHelper
  def hourly_pay_percentage(hourly_pay, eight_members, ten_members)
    total ||= eight_members + ten_members
    return 0 unless total > 0

    case hourly_pay
    when 8
      (eight_members / total) * 100
    when 10
      (ten_members / total) * 100
    end
  end

  def total_hourly_pay_percentage(eight_members, ten_members)
    hourly_pay_percentage(8, eight_members, ten_members) + hourly_pay_percentage(10, eight_members, ten_members)
  end
end
