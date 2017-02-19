class Organizations::RegistrationsController < Devise::RegistrationsController
  require 'pry'

  def new
    @organization = Organization.new
    @organization.users.build
  end

  def create
    @organization = Organization.new(organization_params)
    build_resource(organization_params[:users_attributes]["0"])

    @organization.save
    @user = @organization.users.first
    if @organization.persisted?
      if @user.active_for_authentication?
        flash["success"] = "Your profile and organization were successfully created"
        sign_in @user
        redirect_to home_url(subdomain: @organization.subdomain)
      else
        set_flash_message! :notice, :"signed_up_but_#{@user.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(@user)
      end
    else
      clean_up_passwords(@user)
      respond_with @organization
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :size, :sector, :subdomain, users_attributes: [:first_name, :last_name, :email, :username, :password, :password_confirmation])
  end
end