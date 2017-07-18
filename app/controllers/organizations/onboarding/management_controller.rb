class Organizations::Onboarding::ManagementController < ApplicationController
  before_action :authenticate_user!
  before_action :return_home?

  layout 'organizations/onboarding'

  def index
    @user = current_user
  end
end
