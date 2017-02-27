require 'rails_helper'

describe InviteMailer, type: :mailer do
  let(:organization) { FactoryGirl.create(:organization) }
  let(:invite) { FactoryGirl.create(:invite, organization: organization) }

  describe ".invite_member" do
    let(:mail) { InviteMailer.invite_member(invite) }

    it "renders the subject" do
      expect(mail.subject).to eq("Come join #{organization.name}'s Onboarding Group")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq([invite.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(["feedback@myfirstshift.com"])
    end

    # it "assigns @invite" do
    #   expect(mail.body.encoded).to match(@invite)
    # end

    it "assigns @organization" do
      expect(mail.body.encoded).to match(organization.name)
    end
  end

end