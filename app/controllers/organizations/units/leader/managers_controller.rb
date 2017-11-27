class Organizations::Units::Leader::ManagersController < Organizations::Units::Leader::UnitLeadBaseController
  layout 'organizations/unit_leader'

  def new
    manager = @unit.managers.new

    locals ({
      unit_leader: current_user,
      manager: manager
    })
  end

  def create
    manager = @unit.managers.build(manager_params)

    if manager.save
      flash[:success] = "Manager Created!"
      redirect_to unit_leader_preferences_path
    else
      render :new, locals: { unit_leader: current_user, manager: manager }
    end
  end

  def destroy
    manager = @unit.managers.find(params[:id])

    if manager.delete
      flash[:success] = "Manager Removed"
      redirect_to unit_leader_preferences_path
    else
      flash[:danger] = "There was a problem removing the manager, please try again"
      redirect_to unit_leader_preferences_path
    end
  end

  private

  def manager_params
    params.require(:manager).permit(:name, :description, :picture)
  end
end
