class Organizations::WelcomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    return_home if @user.progress_complete?
  end

  private

  def return_home
    flash[:warning] = "You have already completed your onboarding process"
    redirect_to home_path
  end

end
