class Organizations::Onboarding::FirstDayController < ApplicationController
  before_action :authenticate_user!
  before_action :unit_available?

  layout 'organizations/onboarding'

  def index
    if current_user.progress_applications?
      current_user.update_progress("First Day")
    end

    first_day_items = @organization.first_day_items
    videos = @organization.videos.your_first_day

    locals ({
      user: current_user,
      first_day_items: first_day_items,
      videos: videos
    })
  end
end
