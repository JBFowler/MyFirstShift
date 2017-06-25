require 'rails_helper'

describe Organizations::HomeController, :type => :controller do
  let(:organization) { FactoryGirl.create(:organization) }
  let(:complete_user) { FactoryGirl.create(:user, :completed, organization: organization) }
  let(:incomplete_user) { FactoryGirl.create(:user, organization: organization) }

  before do
    @request.host = "#{organization.subdomain}.myfirstshift.com"
  end

  describe "index" do
    context "when the user has completed their onboarding process" do
      it "shows user their home page" do
        sign_in complete_user

        get :index

        expect(assigns(:user)).to eq(complete_user)
        expect(response).to render_template(:index)
      end
    end

    context "when the user has not completed their onboarding process" do
      it "redirects user to welcome page" do
        sign_in incomplete_user

        get :index

        expect(response).to redirect_to(welcome_path)
      end
    end
  end

  describe "welcome" do
    context "when the user has not completed their onboarding process" do
      it "shows user the welcome page" do
        sign_in incomplete_user

        get :welcome

        expect(assigns(:user)).to eq(incomplete_user)
        expect(response).to render_template(:welcome)
      end
    end

    context "when the user has not completed their onboarding process" do
      it "redirects user to their home page" do
        sign_in complete_user

        get :welcome

        expect(flash[:warning]).to eq("You have already completed your onboarding process")
        expect(response).to redirect_to(home_path)
      end
    end
  end
end
