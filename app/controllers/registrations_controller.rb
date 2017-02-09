class RegistrationsController < ApplicationController
  
  def new
    @user = User.new  
  end

  def create
    binding.pry
    @user = User.new(user_params)

    if @user.save
      flash["success"] = "Your profile was successfully created"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
  end
end