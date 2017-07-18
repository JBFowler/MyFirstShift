class Organizations::Owner::HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  def index
    redirect_to welcome_path
    @user = current_user
  end

end
