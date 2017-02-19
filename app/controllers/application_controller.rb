class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :get_organization

  private

  def get_organization
    binding.pry
    organization = Organization.find_by(subdomain: request.subdomain)

    if organization
      @organization = organization
    elsif request.subdomain != 'www'
      redirect_to root_url(subdomain: 'www')
    end
  end
end
