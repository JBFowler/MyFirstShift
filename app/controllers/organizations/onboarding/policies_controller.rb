class Organizations::Onboarding::PoliciesController < ApplicationController
  before_action :authenticate_user!

  layout 'organizations/onboarding'

  def index
    @user = current_user
  end
end
