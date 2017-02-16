require 'rails_helper'

describe RegistrationsController, :type => :controller do
  let(:user_params) { FactoryGirl.attributes_for(:user) }
  let(:organization_params) { FactoryGirl.attributes_for(:organization, users_attributes: {"0" => user_params} ) }

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
        expect(Organization.all.count).to eq(1)
        expect(flash[:success]).to eq("Your profile and organization were successfully created")
        expect(response).to redirect_to home_path(subdomain: "testcompany")
      end
    end

    context "when the user has invalid params" do
      it "renders the new template with validation errors" do
        post :create, params: { organization: {name: "Test Company"} }

        expect(User.all.count).to eq(0)
        expect(Organization.all.count).to eq(0)
        expect(response).to render_template(:new)
      end
    end
  end
end