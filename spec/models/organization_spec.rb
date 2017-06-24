require 'rails_helper'

describe Organization, :type => :model do
  subject { FactoryGirl.create(:organization) }

  describe "#owners" do
    let(:user) { FactoryGirl.create(:user, :owner, organization: subject) }

    it "returns all owners of an organization" do
      expect(subject.owners).to eq([user])
    end
  end
end
