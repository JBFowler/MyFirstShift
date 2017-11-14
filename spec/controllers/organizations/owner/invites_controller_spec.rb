require 'rails_helper'

describe Organizations::Owner::InvitesController, :type => :controller do
  let(:organization) { FactoryGirl.create(:organization) }
  let(:user) { FactoryGirl.create(:user, :owner, organization: organization) }

  before do
    @request.host = "#{organization.subdomain}.myfirstshift.com"
    sign_in user
    ActionMailer::Base.deliveries = []
  end

  describe "#index" do
    let(:invites) { [FactoryGirl.create(:invite, organization: organization)] }
    it "renders the index template and retrieves all invites for organization" do
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe "#new" do
    it "renders the new template" do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "with valid params" do
      it "creates and sends an invite to a member" do
        post :create, params: { invite: { email: "user@example.com", expires_at: 30.days.from_now } }

        invite = Invite.first
        expect(invite.email).to eq("user@example.com")
        expect(invite.organization).to eq(organization)
        expect(invite.subdomain).to eq(organization.subdomain)
        expect(invite.code).not_to eq(nil)
        expect(invite.created_by).to eq(user)
        expect(flash[:success]).to eq("Invitation Sent!")
        expect(ActionMailer::Base.deliveries.count).to eq(1)
        expect(response).to redirect_to(new_owner_invite_path)
      end
    end

    context "with invalid params" do
      it "renders the new template with errors" do
        post :create, params: { invite: { email: "", expires_at: 30.days.from_now } }

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#update" do
    let(:invite) { FactoryGirl.create(:invite, organization: organization, expires_at: 10.days.from_now, created_by: user) }

    it "resends the invite and updates the expires_at date" do
      put :update, params: { id: invite.id }

      invite.reload
      invite.expires_at.should be > 29.days.from_now
    end
  end

  describe "#destroy" do
    let(:invite) { FactoryGirl.create(:invite, organization: organization, created_by: user) }
    it "soft deletes an invite" do
      delete :destroy, params: { id: invite.id }

      expect(Invite.all.count).to eq(0)
      expect(response).to redirect_to(owner_invites_path)
    end
  end
end
