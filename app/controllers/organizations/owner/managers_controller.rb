class Organizations::Owner::ManagersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def new
    manager = @organization.managers.new

    locals ({
      owner: current_user,
      manager: manager
    })
  end

  def create
    manager = @organization.managers.build(manager_params)

    if manager.save
      flash[:success] = "Manager Created!"
      redirect_to owner_preferences_path
    else
      render :new, locals: { owner: current_user, manager: manager }
    end
  end

  def destroy
    manager = @organization.managers.find(params[:id])

    if manager.delete
      flash[:success] = "Manager Removed"
      redirect_to owner_preferences_path
    else
      flash[:danger] = "There was a problem removing the manager, please try again"
      redirect_to owner_preferences_path
    end
  end

  private

  def manager_params
    params.require(:manager).permit(:name, :description, :picture, :email)
  end
end
