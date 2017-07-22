class Organizations::WelcomeController < ApplicationController
  before_action :authenticate_user!
  before_action :return_home?

  layout 'organizations/home'

  def index
    @user = current_user
    flash.now[:success] = "Welcome to #{@organization.name}!  We are excited to have you as a part of our company!"
  end
end