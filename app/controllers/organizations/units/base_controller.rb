class Organizations::Units::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :require_unit
  before_action :get_unit

  def require_unit
    redirect_to home_path unless current_user.unit
  end

  private

  def get_unit
    @unit = @organization.units.friendly.find(params[:unit_id])
  end
end
