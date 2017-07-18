class AddOnboardingStepsToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :onboarding_steps, :string, array: true, default: []
  end
end
