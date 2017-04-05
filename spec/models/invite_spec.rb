require 'rails_helper'

describe Invite, :type => :model do
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of(:email).scoped_to(:subdomain).with_message("has already been sent an invite") }
  it { should belong_to(:organization) }
  it { should belong_to(:unit) }

  subject { FactoryGirl.create(:invite, :with_code) }

  describe "#redeem" do
    let(:user) { FactoryGirl.create(:user, email: subject.email) }

    it "redeems the invite" do
      time = DateTime.current
      allow(DateTime).to receive(:current).and_return(time)

      subject.redeem(user)

      expect(subject.redeemed_at).to eq(time)
      expect(subject.redeemed_by).to eq(user.id)
    end
  end

end
