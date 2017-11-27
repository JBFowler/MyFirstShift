class Organizations::Units::Leader::UnitsController < Organizations::Units::Leader::UnitLeadBaseController
  layout 'organizations/unit_leader'

  def update
    if params[:unit] && @unit.update(unit_params)
      flash[:success] = "Store Front Added!"
      redirect_to unit_leader_preferences_path(@unit)
    else
      flash[:danger] = "There was an issue adding the store front image, please try again"
      redirect_to unit_leader_preferences_path(@unit)
    end
  end

  private

  def unit_params
    params.require(:unit).permit(:store_front)
  end
end
