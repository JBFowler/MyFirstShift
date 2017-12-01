class Organizations::Owner::FirstDayItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def create
    first_day_item = @organization.first_day_items.build(first_day_item_params)

    if first_day_item.save
      if @organization.units.any?
        @organization.units.each do |unit|
          unit.first_day_items.build(first_day_item_params)
          unit.save
        end
      end

      flash[:success] = "First Day Item Added!"
      redirect_to owner_preferences_path
    else
      flash[:danger] = "There was a problem adding the First Day Item, please try again!"
      redirect_to owner_preferences_path
    end
  end

  def destroy
    first_day_item = @organization.first_day_items.find(params[:id])

    if first_day_item.delete
      flash[:success] = "First Day Item Removed"
      redirect_to owner_preferences_path
    else
      flash[:danger] = "There was a problem removing the First Day Item, please try again"
      redirect_to owner_preferences_path
    end
  end

  private

  def first_day_item_params
    params.require(:first_day_item).permit(:title, list_items: [])
  end
end
