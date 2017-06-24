require 'rails_helper'

describe User, :type => :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:password_confirmation) }
  it { should belong_to(:organization) }

  describe "#owner?" do
    let(:user) { FactoryGirl.create(:user, :owner) }
    it "returns true if users role is equal to owner" do
      expect(user.owner?).to eq(true)
    end
  end

  describe "#full_name" do
    let(:user) { FactoryGirl.create(:user) }

    it "returns the full name of the user" do
      expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
    end
  end
end
