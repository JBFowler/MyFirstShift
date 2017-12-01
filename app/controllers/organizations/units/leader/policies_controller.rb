class Organizations::Units::Leader::PoliciesController < Organizations::Units::Leader::UnitLeadBaseController
  layout 'organizations/unit_leader'

  def index
    policies = @unit.policies

    locals ({
      policies: policies,
      unit_leader: current_user
    })
  end

  def create
    policy = @unit.policies.build(policy_params)

    if policy.save
      flash[:success] = "policy Added!"
      redirect_to unit_leader_policies_path(@unit)
    else
      flash[:danger] = "There was a problem adding the policy, please try again!"
      redirect_to unit_leader_policies_path(@unit)
    end
  end

  def destroy
    policy = @unit.policies.find(params[:id])

    if @unit.policies.delete(policy)
      flash[:success] = "Policy Removed!"
      redirect_to unit_leader_policies_path(@unit)
    else
      flash[:danger] = "There was a problem removing the policy, please try again!"
      redirect_to unit_leader_policies_path(@unit)
    end
  end

  private

  def policy_params
    params.require(:policy).permit(:name, :description)
  end
end
