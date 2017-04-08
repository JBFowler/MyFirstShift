class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :get_organization
  before_action :get_mailer_host

  private

  def get_organization
    organization = Organization.find_by(subdomain: request.subdomain)

    if organization
      @organization = organization
    elsif request.subdomain != ''
      redirect_to root_url(subdomain: '')
    end
  end

  def get_mailer_host
    ActionMailer::Base.default_url_options = {:host => request.host_with_port}
  end

  def after_sign_in_path_for(resource)
    home_url
  end
end
