require 'rails_helper'

describe SignIn::OrganizationsController, :type => :controller do
  before do
    @request.host = "myfirstshift.com"
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

        expect(flash[:warning]).to eq("The subdomain could not be found.  Please enter a different subdomain.")
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe "GET #find_user" do
    it "renders the find_user template and allows user to find invitations they have been sent" do
      get :find_user
      expect(response).to render_template(:find_user)
    end
  end

  describe "POST #send_notification" do
    before { ActionMailer::Base.deliveries = [] }

    context "when an invite exists for the email" do
      let(:organization) { FactoryGirl.create(:organization) }
      let(:invite) { FactoryGirl.create(:invite, organization: organization) }
      it "finds all invites/accounts associated to the email and sends a invite/join notification via email" do
        post :send_notification, params: { email: invite.email }

        expect(ActionMailer::Base.deliveries.count).to eq(1)
        expect(flash[:success]).to eq("Any accounts associated with the email #{invite.email} have been notified via email")
        expect(response).to redirect_to(sign_in_find_path)
      end
    end

    context "when an invite/account does not exist for the email" do
      it "no email is sent to the entered email" do
        post :send_notification, params: { email: "noemail@example.com" }

        expect(ActionMailer::Base.deliveries.count).to eq(0)
        expect(flash[:success]).to eq("Any accounts associated with the email noemail@example.com have been notified via email")
        expect(response).to redirect_to(sign_in_find_path)
      end
    end
  end
end
