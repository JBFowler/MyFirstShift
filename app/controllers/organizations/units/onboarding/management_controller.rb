class Organizations::Units::Onboarding::ManagementController < Organizations::Units::BaseController
  layout 'organizations/units/onboarding'

  def index
    managers = get_managers

    store_front = get_store_front
    videos = get_introduction_videos

    locals ({
      user: current_user,
      managers: managers,
      store_front: store_front,
      videos: videos
    })
  end

  private

  def get_managers
    if @unit.managers.any?
      return @unit.managers
    else
      return @organization.managers
    end
  end

  def get_store_front
    if @unit.store_front.file
      return @unit.store_front
    else
      return @organization.store_front
    end
  end

  def get_introduction_videos
    if @unit.videos.introduction.any?
      return @unit.videos.introduction
    else
      return @organization.videos.introduction
    end
  end
end
