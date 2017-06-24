require 'rails_helper'

describe Organizations::RegistrationsController, :type => :controller do
  let(:user_params) { FactoryGirl.attributes_for(:user) }
  let(:organization_params) { FactoryGirl.attributes_for(:organization, users_attributes: {"0" => user_params}) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @request.host = "myfirstshift.com"
  end

  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
      expect(assigns(:organization)).to be_a_new(Organization)
    end
  end

  describe "POST #create" do
    context "when there are valid params present" do
      it "creates a user and an organization" do
        post :create, params: { organization: organization_params }

        expect(User.all.count).to eq(1)
        expect(User.first.role).to eq("owner")
        expect(User.first.subdomain).to eq(Organization.first.subdomain)
        expect(Organization.all.count).to eq(1)
        expect(flash[:success]).to eq("Your profile and organization were successfully created")
        expect(response).to redirect_to new_user_session_url(subdomain: Organization.first.subdomain)
      end
    end

    context "when the user has invalid params" do
      let(:invalid_user_params) { FactoryGirl.attributes_for(:user, password: "test", password_confiramtion: "test_1") }
      let(:invalid_organization_params) { FactoryGirl.attributes_for(:organization, name: "", users_attributes: {"0" => invalid_user_params}) }
      it "renders the new template with validation errors" do
        post :create, params: { organization: invalid_organization_params }

        expect(User.all.count).to eq(0)
        expect(Organization.all.count).to eq(0)
        expect(response).to render_template(:new)
      end
    end
  end
end
