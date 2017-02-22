require 'rails_helper'

describe SignIn::OrganizationsController, :type => :controller do
  before do
    @request.host = "www.myfirstshift.com"
  end

  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "POST #find_subdomain" do
    context "when the subdomain exists" do
      let(:organization) { FactoryGirl.create(:organization, subdomain: "testgroup") }
      it "searches for the subdomain and redirects to the sign in page for that specific subdomain" do
        get :find_subdomain, params: { search_term: organization.subdomain }

        expect(response).to redirect_to(new_user_session_url(subdomain: organization.subdomain))
      end
    end

    context "when the subdomain does not exist" do
      it "renders the find_subdomain template and displays flash message" do
        get :find_subdomain, params: { search_term: "badsubdomain" }

        expect(flash[:error]).to eq("The subdomain could not be found.  Please enter a different subdomain.")
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end
end