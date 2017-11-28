class Organizations::Onboarding::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :return_home?

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
    if current_user.progress_intro?
      current_user.update_progress("Employee Info")
    end

    locals ({
      user: current_user
    })
  end

  def update
    user = current_user

    if @user.update(user_params)
      redirect_to onboarding_paperwork_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:employee_type, :phone, :date_of_birth)
  end
end
