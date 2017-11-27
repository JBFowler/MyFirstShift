class Organizations::Owner::OrganizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def update
    if params[:organization] && @organization.update(organization_params)
      flash[:success] = "Store Front Added!"
      redirect_to owner_preferences_path
    else
      flash[:danger] = "There was an issue adding the store front image, please try again"
      redirect_to owner_preferences_path
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:store_front)
  end
end
