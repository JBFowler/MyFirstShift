class SignIn::OrganizationsController < ApplicationController

  def index
    
  end

  def find_subdomain
    @organization = Organization.search_by_subdomain(params[:search_term])

    if @organization
      redirect_to new_user_session_url(subdomain: @organization.subdomain)
    else
      flash.now[:error] = "The subdomain could not be found.  Please enter a different subdomain."
      render :index
    end
  end
  
end