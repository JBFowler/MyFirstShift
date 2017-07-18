class AddOnboardingStepsToUnits < ActiveRecord::Migration[5.0]
  def change
    add_column :units, :onboarding_steps, :string, array: true, default: []
  end
end
