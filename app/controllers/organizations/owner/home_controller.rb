class Organizations::Owner::HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    # redirect_to welcome_pathx
    @owner = current_user
  end

end
