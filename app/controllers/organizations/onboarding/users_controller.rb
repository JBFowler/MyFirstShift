class Organizations::Onboarding::UsersController < ApplicationController
  before_action :authenticate_user!

  layout 'organizations/onboarding'

  def complete
    @user = current_user
    if @user.complete!
      redirect_to home_path
    else
      redirect_to welcome_path
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to onboarding_paperwork_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:employee_type, :phone)
  end
end
