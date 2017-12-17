class Organizations::Units::Onboarding::FirstDayController < Organizations::Units::BaseController
  layout 'organizations/units/onboarding'

  def index
    if current_user.progress_applications?
      current_user.update_progress("First Day")
    end

    first_day_items = get_first_day_items
    videos = get_first_day_videos

    locals ({
      user: current_user,
      first_day_items: first_day_items,
      videos: videos
    })
  end

  private

  def get_first_day_items
    if @unit.first_day_items.any?
      return @unit.first_day_items
    else
      return @organization.first_day_items
    end
  end

  def get_first_day_videos
    if @unit.videos.your_first_day.any?
      return @unit.videos.your_first_day
    else
      return @organization.videos.your_first_day
    end
  end
end
