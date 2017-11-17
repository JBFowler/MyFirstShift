class Organizations::Owner::UnitsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    units = @organization.units.with_deleted

    if params[:search]
      units = ::Services::Unit::FindUnitService.search(units, params[:search]) unless params[:search].blank?
    end

    if params[:sort]
      units = units.order(params[:sort]) unless params[:sort].blank?
    end

    locals ({
      owner: current_user,
      units: units
    })
  end

  def show
    unit = @organization.units.with_deleted.find(params[:id])

    locals ({
      owner: current_user,
      unit: unit
    })
  end

  def new
    unit = Unit.new

    locals ({
      owner: current_user,
      unit: unit
    })
  end

  def create
    unit = @organization.units.build(unit_params)
    unit.assign_attributes(created_by: current_user)

    if unit.save
      flash[:success] = "Unit Created!"
      redirect_to owner_unit_path(unit)
    else
      render :new, locals: { owner: current_user, unit: unit }
    end
  end

  def edit
    unit = @organization.units.find(params[:id])

    locals ({
      owner: current_user,
      unit: unit
    })
  end

  def update
    unit = @organization.units.find(params[:id])

    if unit.update(unit_params)
      flash[:success] = "#{unit.name} has been updated!"
      redirect_to owner_unit_path(unit)
    else
      render :edit, locals: { owner: current_user, unit: unit }
    end
  end

  def destroy
    unit = @organization.units.find(params[:id])

    if unit.destroy
      redirect_to owner_unit_path(unit)
    else
      flash[:danger] = "There was a problem deleting the unit"
      redirect_to owner_unit_path(unit)
    end
  end

  private

  def unit_params
    params.require(:unit).permit(:name, :city, :state)
  end
end
