class Organizations::Units::Leader::UnitLeadBaseController < ApplicationController
  before_action :authenticate_user!
  before_action :require_unit_leader
  before_action :get_unit

  def require_unit_leader
    unless user_signed_in? && (current_user.unit_leader? || current_user.owner?)
      flash[:danger] = "You can't do that."
      redirect_to home_path
    end
  end

  private

  def get_unit
    if current_user.owner?
      @unit = @organization.units.friendly.find(params[:unit_id])
    else
      @unit = current_user.unit
    end
  end
end
