class Organizations::HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    # redirect_to welcome_path unless @user.progress_complete?
  end
end
