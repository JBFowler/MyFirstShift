class RegistrationsController < Devise::RegistrationsController

  # def new
  #   @organization = Organization.new
  #   @organization.users.build
  # end

  # def create
  #   @organization = Organization.new(organization_params)

  #   if @organization.save
  #     flash["success"] = "Your profile and organization were successfully created"
  #     redirect_to home_path(subdomain: @organization.subdomain)
  #   else
  #     render :new
  #   end
  # end

  private

  def sign_up_params
    params.require(:organization).permit(:name, :size, :sector, :subdomain, users_attributes: [:first_name, :last_name, :email, :username, :password])
  end
end