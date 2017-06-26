class Organizations::Onboarding::UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to home_path#onboarding_paperwork_overview_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:employee_type, :phone)
  end
end
