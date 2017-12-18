class Organizations::Onboarding::ManagementController < ApplicationController
  before_action :authenticate_user!
  before_action :unit_available?

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
