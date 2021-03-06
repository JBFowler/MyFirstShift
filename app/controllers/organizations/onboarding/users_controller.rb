class Organizations::Onboarding::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :unit_available?

  layout 'organizations/onboarding'

  def complete
    if current_user.progress_first_day?
      current_user.complete!
    end

    redirect_to home_path
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

    if user.update(user_params)
      if current_user.progress_employee_info?
        current_user.update_progress("Paperwork")
      end

      redirect_to onboarding_paperwork_path
    else
      render :edit, locals: { user: user }
    end
  end

  private

  def user_params
    params.require(:user).permit(:employee_type, :phone, :date_of_birth, :ssn, :drivers_license_number, :drivers_license_expiration, :passport_number, :passport_expiration)
  end
end
