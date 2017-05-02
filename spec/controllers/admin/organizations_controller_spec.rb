require 'rails_helper'

describe Admin::OrganizationsController, :type => :controller do
  before do
    @request.host = "supernova.myfirstshift.com"
    @request.env['devise.mapping'] = Devise.mappings[:admin]
    sign_in admin
  end

  let(:admin) { FactoryGirl.create(:admin) }

  describe "#index" do
    it "renders the index template and assigns organizations" do
      get :index

      expect(assigns(:organizations)).to eq(Organization.unscoped)
      expect(response).to render_template(:index)
    end
  end

  describe "#show" do
    let(:organization) { FactoryGirl.create(:organization) }
    it "renders the show template and displays the organization" do
      get :show, params: { id: organization.id }

      expect(assigns(:organization)).to eq(organization)
      expect(response).to render_template(:show)
    end
  end

  describe "#new" do
    it "renders the new page and assings organization" do
      get :new

      expect(assigns(:organization)).to be_an_instance_of(Organization)
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "when valid params are present" do
      let(:organization_params) { FactoryGirl.attributes_for(:organization) }

      it "creates a new organization" do
        post :create, params: { organization: organization_params }

        expect(Organization.all.count).to eq(1)
        expect(flash[:success]).to eq("#{Organization.first.name} was successfully created")
        expect(response).to redirect_to admin_organization_path(Organization.first)
      end
    end

    context "when invalid params are present" do
      it "does not create organization and returns errors" do
        post :create, params: { organization: {name: "", size: 30, sector: "", subdomain: ""}}

        expect(Organization.all.count).to eq(0)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#edit" do
    let(:organization) { FactoryGirl.create(:organization) }
    it "renders the edit template for the chosen organization" do
      get :edit, params: { id: organization.id }

      expect(assigns(:organization)).to eq(organization)
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    let(:organization) { FactoryGirl.create(:organization) }

    context "when valid params are present" do
      it "updates the organization with new attribute values" do
        patch :update, params: { id: organization.id, organization: {name: "Test Name", size: 10, sector: "Business", subdomain: "newsubdomain"}}

        organization.reload

        expect(organization.name).to eq("Test Name")
        expect(organization.size).to eq(10)
        expect(organization.sector).to eq("Business")
        expect(organization.subdomain).to eq("newsubdomain")
        expect(flash[:success]).to eq("Test Name has been updated")
        expect(response).to redirect_to(admin_organization_path(organization))
      end
    end

    context "when invalid params are present" do
      it "does not update the organization and renders the edit tempate" do
        patch :update, params: { id: organization.id, organization: {name: "", size: 10, sector: "Business", subdomain: "bad_subdomain"}}

        expect(organization.errors).not_to be_nil
        expect(response).to render_template(:edit)
      end
    end
  end
end
