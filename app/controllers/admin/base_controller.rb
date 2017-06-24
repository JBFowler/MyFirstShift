class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!
  before_action :is_admin?

  layout "admin"

  private

  def is_admin?
    sign_out_and_redirect(current_admin) unless current_admin && access_whitelist
  end

  def access_whitelist
    current_admin.try(:admin?)
  end
end
