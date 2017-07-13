require 'rails_helper'

describe User, :type => :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  #it { should validate_presence_of(:password) }
  #it { should validate_presence_of(:password_confirmation) }
  it { should belong_to(:organization) }

  subject { FactoryGirl.create(:user) }

  describe "#owner?" do
    let(:user) { FactoryGirl.create(:user, :owner) }
    it "returns true if users role is equal to owner" do
      expect(user.owner?).to eq(true)
    end
  end

  describe "#complete!" do
    it "sets the users progress to complete" do
      subject.complete!

      expect(subject.progress_complete?).to eq(true)
    end
  end

  describe "#full_name" do
    it "returns the full name of the user" do
      expect(subject.full_name).to eq("#{subject.first_name} #{subject.last_name}")
    end
  end

  describe "#progress_complete?" do
    context "when the user hasn't finished onboarding process" do
      it "returns false for the user" do
        expect(subject.progress_complete?).to eq(false)
      end
    end

    context "when the user has finished onboarding process" do
      subject { FactoryGirl.create(:user, :completed) }

      it "returns true for the user" do
        expect(subject.progress_complete?).to eq(true)
      end
    end
  end
end
