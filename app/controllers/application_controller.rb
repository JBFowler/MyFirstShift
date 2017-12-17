class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :get_organization
  before_action :get_mailer_host

  helper_method :not_found, :unit_available?

  def require_owner
    unless user_signed_in? && current_user.owner?
      flash[:danger] = "You can't do that."
      redirect_to home_path
    end
  end

  def unit_available?
    redirect_to unit_home_path(current_user.unit) if current_user.unit
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

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
      if current_user.unit
        unit_home_path(current_user.unit)
      else
        home_path
      end
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

  def locals(values)
    render locals: values
  end
end
