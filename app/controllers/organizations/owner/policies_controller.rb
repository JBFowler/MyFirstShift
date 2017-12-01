class Organizations::Owner::PoliciesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    policies = @organization.policies

    locals ({
      policies: policies,
      owner: current_user
    })
  end

  def create
    policy = @organization.policies.build(policy_params)

    if policy.save
      if @organization.units.any?
        @organization.units.each do |unit|
          unit.policies.build(policy_params)
          unit.save
        end
      end

      flash[:success] = "Policy Added!"
      redirect_to owner_policies_path
    else
      flash[:danger] = "There was a problem adding the policy, please try again!"
      redirect_to owner_policies_path
    end
  end

  def destroy
    policy = @organization.policies.find(params[:id])

    if policy.delete
      flash[:success] = "Policy Removed!"
      redirect_to owner_policies_path
    else
      flash[:danger] = "There was a problem removing the policy, please try again!"
      redirect_to owner_policies_path
    end
  end

  private

  def policy_params
    params.require(:policy).permit(:name, :description)
  end
end

