require 'rails_helper'

describe NotificationMailer, type: :mailer do
  let(:organization) { FactoryGirl.create(:organization) }
  let(:email) { "user@example.com" }
  let(:users) { [FactoryGirl.create(:user, email: email, organization: organization)] }
  let(:invites) { [FactoryGirl.create(:invite, :with_code, email: email, organization: organization)] }

  before { ActionMailer::Base.default_url_options = { :host => "subdomain.myfirstshift.com" } }

  describe ".notify" do
    let(:mail) { NotificationMailer.notify(email, users, invites) }

    it "renders the subject" do
      expect(mail.subject).to eq("Your Organizations")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq([email])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(["feedback@myfirstshift.com"])
    end

    it "assigns @email" do
      expect(mail.body.encoded).to match(email)
    end

    it "assigns @invites" do
      # expect(mail.body.encoded).to match(invite.code)
    end

    it "assigns @users" do
      # expect(mail.body.encoded).to match(organization.name)
    end
  end

end
