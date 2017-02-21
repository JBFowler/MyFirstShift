class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :get_organization

  private

  def get_organization
    organization = Organization.find_by(subdomain: request.subdomain)

    if organization
      @organization = organization
    elsif request.subdomain != 'www'
      redirect_to root_url(subdomain: 'www')
    end
  end

  def after_sign_in_path_for(resource)
    home_url
  end
end
