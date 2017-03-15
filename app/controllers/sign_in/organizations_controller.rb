class SignIn::OrganizationsController < ApplicationController

  def index
  end

  def find_subdomain
    @organization = Organization.search_by_subdomain(params[:search_term])

    if @organization
      redirect_to new_user_session_url(subdomain: @organization.subdomain)
    else
      flash[:warning] = "The subdomain could not be found.  Please enter a different subdomain."
      redirect_to sign_in_path
    end
  end

  def find_user
    
  end

  def send_notification
    @email = params[:email]
    @users = User.where(email: @email)
    @invites = Invite.where(email: @email)
    @accounts = @users + @invites

    if @accounts.any?
      NotificationMailer.notify(@email, @users, @invites).deliver
    end
    flash[:success] = "Any accounts associated with the email #{@email} have been notified via email"
    render :find_user
  end
end