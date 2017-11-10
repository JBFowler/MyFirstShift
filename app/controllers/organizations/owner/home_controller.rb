class Organizations::Owner::HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    locals ({
      owner: current_user,
      active_users: @organization.members.active,
      ready_to_schedule: @organization.members.ready_to_schedule,
      past_twelve_months: get_months
    })
  end

  private

  def get_months
    arr = []
    12.times do |n|
      arr << @organization.members.where('extract(month from created_at) = ?', n.months.ago.month).count
    end
    return arr.reverse
  end
end
