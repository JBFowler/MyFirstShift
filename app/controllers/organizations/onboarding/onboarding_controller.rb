class Organizations::Onboarding::OnboardingController < ApplicationController
  before_action :authenticate_user!

  def meet_the_management
    @user = current_user
  end

  def employee_info
    @user = current_user
  end

  def add_employee_info
    @user = current_user
    if @user.update(employee_info_params)
      redirect_to onboarding_paperwork_overview_path
    else
      render :employee_info
    end
  end

  private

  def employee_info_params
    params.require(:user).permit(:employee_type, :phone)
  end
end
