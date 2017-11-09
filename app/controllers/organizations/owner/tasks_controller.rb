class Organizations::Owner::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    @owner = current_user
  end

end
