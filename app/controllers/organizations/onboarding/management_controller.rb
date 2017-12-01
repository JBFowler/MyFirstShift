class Organizations::Onboarding::ManagementController < ApplicationController
  before_action :authenticate_user!

  layout 'organizations/onboarding'

  def index
    managers = @organization.managers
    store_front = @organization.store_front
    videos = @organization.videos.introduction

    locals ({
      user: current_user,
      managers: managers,
      store_front: store_front,
      videos: videos
    })
  end
end
