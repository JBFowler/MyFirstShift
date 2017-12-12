require 'rails_helper'

describe InviteMailer, type: :mailer do
  let(:organization) { FactoryGirl.create(:organization) }
  let(:user) { FactoryGirl.create(:user) }

  describe ".invite_member" do
    let(:invite) { FactoryGirl.create(:invite, :with_code, organization: organization, created_by: user) }
    let(:mail) { InviteMailer.invite_member(invite) }

    before { ActionMailer::Base.default_url_options = { :host => "subdomain.myfirstshift.com" } }

    it "renders the subject" do
      expect(mail.subject).to eq("Join #{organization.name}'s Onboarding Group")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq([invite.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(["feedback@myfirstshift.com"])
    end

    it "assigns @invite" do
      expect(mail.body.encoded).to match(invite.code)
    end

    it "assigns @organization" do
      expect(mail.body.encoded).to match(organization.name)
    end
  end

  describe ".invite_owner" do
    let(:invite) { FactoryGirl.create(:invite, :with_code, :owner, organization: organization, created_by: user) }
    let(:mail) { InviteMailer.invite_owner(invite) }

    before { ActionMailer::Base.default_url_options = { :host => "supernova.myfirstshift.com" } }

    it "renders the subject" do
      expect(mail.subject).to eq("Set up your account for #{organization.name}'s Onboarding Group")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq([invite.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(["feedback@myfirstshift.com"])
    end

    it "assigns @invite" do
      expect(mail.body.encoded).to match(invite.code)
    end

    it "assigns @organization" do
      expect(mail.body.encoded).to match(organization.name)
    end
  end

end
