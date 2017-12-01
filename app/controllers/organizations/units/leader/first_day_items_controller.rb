class Organizations::Units::Leader::FirstDayItemsController < Organizations::Units::Leader::UnitLeadBaseController
  layout 'organizations/unit_leader'

  def create
    first_day_item = @unit.first_day_items.build(first_day_item_params)

    if first_day_item.save
      flash[:success] = "First Day Item Added!"
      redirect_to unit_leader_preferences_path(@unit)
    else
      flash[:danger] = "There was a problem adding the First Day Item, please try again!"
      redirect_to unit_leader_preferences_path(@unit)
    end
  end

  def destroy
    first_day_item = @unit.first_day_items.find(params[:id])

    if @unit.first_day_items.delete(first_day_item)
      flash[:success] = "First Day Item Removed"
      redirect_to unit_leader_preferences_path(@unit)
    else
      flash[:danger] = "There was a problem removing the First Day Item, please try again"
      redirect_to unit_leader_preferences_path(@unit)
    end
  end

  private

  def first_day_item_params
    params.require(:first_day_item).permit(:title, list_items: [])
  end
end
