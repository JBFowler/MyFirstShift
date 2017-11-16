require 'rails_helper'

describe Invite, :type => :model do
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of(:email).scoped_to(:subdomain).with_message("has already been sent an invite. Please go to list of invites to resend the invitation.") }
  it { should belong_to(:organization) }
  it { should belong_to(:unit) }

  let(:invite_creator) { FactoryGirl.create(:user) }
  subject { FactoryGirl.create(:invite, :with_code, created_by: invite_creator) }

  describe "#redeem" do
    let(:user) { FactoryGirl.create(:user, email: subject.email, organization: subject.organization) }

    it "redeems the invite" do
      time = DateTime.current
      allow(DateTime).to receive(:current).and_return(time)

      subject.redeem(user)

      expect(subject.redeemed_at).to eq(time)
      expect(subject.redeemed_by).to eq(user)
    end
  end

  describe "#redeemer" do
    let(:user) { FactoryGirl.create(:user, email: subject.email, organization: subject.organization) }

    it "returns the full name of the user who redeemed the invite" do
      subject.redeem(user)

      expect(subject.redeemer).to eq("#{user.first_name} #{user.last_name}")
    end
  end
end
