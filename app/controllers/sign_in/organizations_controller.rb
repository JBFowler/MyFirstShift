class SignIn::OrganizationsController < ApplicationController

  def index
  end

  def find_subdomain
    @organization = Organization.search_by_subdomain(params[:search_term])

    if @organization
      redirect_to new_user_session_url(subdomain: @organization.subdomain)
    else
      flash[:error] = "The subdomain could not be found.  Please enter a different subdomain."
      redirect_to sign_in_path
    end
  end

  def find_user
    
  end

  def send_notification
    @users = User.where(email: params[:email])
    @invites = Invite.where(email: params[:email])

    if @users.any? || @invites.any?

    else
      redirect_to 
    end
  end
end