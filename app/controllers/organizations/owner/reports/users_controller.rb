class Organizations::Owner::Reports::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    members = ::Services::Reports::MemberReportBuilderService.filter(@organization, params)

    respond_to do |format|
      format.html do
        locals ({
          owner: current_user,
          members: members
        })
      end
      format.csv { send_data members.to_csv, filename: "members-#{Date.today}.csv" }
    end
  end
end
