require 'rails_helper'

describe Organizations::Owner::InvitesController, :type => :controller do
  let(:organization) { FactoryGirl.create(:organization) }
  let(:user) { FactoryGirl.create(:user, :owner, organization: organization) }

  before do
    @request.host = "#{organization.subdomain}.myfirstshift.com"
    sign_in user
  end

  describe "#index" do
    let(:invites) { [FactoryGirl.create(:invite, organization: organization)] }
    it "renders the index template and retrieves all invites for organization" do
      get :index

      expect(assigns(:invites)).to eq(invites)
      expect(response).to render_template(:index)
    end
  end

  describe "#new" do
    it "renders the new template" do
      get :new

      expect(assigns(:invite)).to be_instance_of(Invite)
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
        expect(flash[:success]).to eq("The user has been invited")
        expect(ActionMailer::Base.deliveries.count).to eq(1)
        expect(response).to redirect_to(owner_invites_path)
      end
    end

    context "with invalid params" do
      it "renders the new template with errors" do
        post :create, params: { invite: { email: "", expires_at: 30.days.from_now } }

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#destroy" do
    let(:invite) { FactoryGirl.create(:invite, organization: organization) }
    it "soft deletes an invite" do
      delete :destroy, params: { id: invite.id }

      expect(Invite.all.count).to eq(0)
      expect(response).to redirect_to(owner_invites_path)
    end
  end
end
