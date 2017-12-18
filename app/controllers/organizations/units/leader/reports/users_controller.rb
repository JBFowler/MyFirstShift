class Organizations::Units::Leader::Reports::UsersController < Organizations::Units::Leader::UnitLeadBaseController
  layout 'organizations/unit_leader'

  def index
    members = ::Services::Reports::MemberReportBuilderService.filter(@unit, params)

    respond_to do |format|
      format.html do
        locals ({
          unit_leader: current_user,
          members: members
        })
      end
      format.csv { send_data members.to_csv, filename: "members-#{Date.today}.csv" }
    end
  end
end
