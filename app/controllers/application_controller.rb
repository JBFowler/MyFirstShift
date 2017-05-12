class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :get_organization
  before_action :get_mailer_host

  private

  def get_organization
    if request.subdomain != '' && request.subdomain != 'supernova'
      @organization = Organization.find_by(subdomain: request.subdomain)
    end
  end

  def get_mailer_host
    ActionMailer::Base.default_url_options = {:host => request.host_with_port}
  end

  def after_sign_in_path_for(resource_or_scope)
    case request.subdomain
    when 'supernova'
      admin_home_path
    else
      home_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    case request.subdomain
    when 'supernova'
      new_admin_session_path
    else
      root_path
    end
  end
end
