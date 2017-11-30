class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :get_organization
  before_action :get_mailer_host

  helper_method :allowed_onboarding_access?, :return_home?, :not_found

  def require_owner
    unless user_signed_in? && current_user.owner?
      flash[:danger] = "You can't do that."
      redirect_to home_path
    end
  end

  def return_home?
    if current_user.progress_complete?
      flash[:warning] = "You have already completed your onboarding process"
      redirect_to home_path
    end
  end

  def allowed_onboarding_access?(progress_point)
    @progress_points ||= ["Intro", "Employee Info", "Paperwork", "FAQ", "Policies", "Applications", "First Day", "Complete"]

    if @progress_points.index(current_user.progress) >= @progress_points.index(progress_point)
      return
    else
      redirect_to home_path
    end
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

  def locals(values)
    render locals: values
  end
end
