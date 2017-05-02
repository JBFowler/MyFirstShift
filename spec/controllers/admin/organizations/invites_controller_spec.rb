require 'rails_helper'

describe Admin::Organizations::InvitesController, :type => :controller do
  let(:organization) { FactoryGirl.create(:organization) }
  let(:admin) { FactoryGirl.create(:admin) }

  before do
    @request.host = "supernova.myfirstshift.com"
    @request.env['devise.mapping'] = Devise.mappings[:admin]
    sign_in admin
  end

  describe "#index" do

  end

  describe "#new" do
    it "renders the new template for an invite" do
      get :new, params: { organization_id: organization.id }

      expect(assigns(:invite)).to be_an_instance_of(Invite)
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "when valid params are present" do
      it "creates an sends an invitation to an owner" do
        post :create, params: { organization_id: organization.id, invite: { email: "owner@testcompany.com", subdomain: organization.subdomain, expires_at: 30.days.from_now, role: "owner"}}

        expect(Invite.all.count).to eq(1)
        expect(Invite.first.role).to eq("owner")
        expect(Invite.first.subdomain).to eq(organization.subdomain)
        expect(ActionMailer::Base.deliveries.count).to eq(1)
        expect(response).to redirect_to(admin_organization_invites_path(organization))
      end
    end

    context "when invalid params are present" do
      it "renders the new template with errors" do
        post :create, params: { organization_id: organization.id, invite: { email: "", subdomain: organization.subdomain, expires_at: 30.days.from_now, role: "owner"}}

        expect(Invite.all.count).to eq(0)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#destroy" do
    let(:invite) { FactoryGirl.create(:invite, :with_code, organization: organization) }
    it "soft deletes the invite" do
      delete :destroy, params: { organization_id: organization.id, id: invite.id }

      invite.reload

      expect(invite.deleted_at).not_to be_nil
      expect(Invite.all.count).to eq(0)
      expect(response).to redirect_to(admin_organization_invites_path(organization))
    end
  end
end
