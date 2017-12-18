module Services
  module Reports
    class MemberReportBuilderService
      def self.filter(organization, params)
        filtering_params = params.slice(:progress, :role, :employee_type, :e_verified, :state_verified)

        results = organization.members.with_deleted
        filtering_params.each do |key, value|
          results = results.public_send(key, value)
        end

        results.order(:last_name)
      end
    end
  end
end
