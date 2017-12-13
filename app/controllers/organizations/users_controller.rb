class Organizations::UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    locals ({
      user: current_user
    })
  end

  def update
    user = current_user

    if user.update(user_params)

      redirect_to home_path
    else
      render :edit, locals: { user: user }
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :employee_type, :phone, :date_of_birth, :ssn, :drivers_license_number, :drivers_license_expiration, :passport_number, :passport_expiration)
  end
end
