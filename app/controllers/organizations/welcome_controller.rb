class Organizations::WelcomeController < ApplicationController
  before_action :authenticate_user!

  layout 'organizations/home'

  def index
    @user = current_user
    flash.now[:success] = "Welcome to #{@organization.name}!  We are excited to have you as a part of our company!"
    return_home if @user.progress_complete?
  end

  private

  def return_home
    flash[:warning] = "You have already completed your onboarding process"
    redirect_to home_path
  end

end
