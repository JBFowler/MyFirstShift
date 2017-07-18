require 'rails_helper'

describe Organizations::Onboarding::AppsController, :type => :controller do
  let(:organization) { FactoryGirl.create(:organization) }
  let(:user) { FactoryGirl.create(:user, organization: organization) }

  before do
    @request.host = "#{organization.subdomain}.myfirstshift.com"
    sign_in user
  end

  describe "#index" do
    it "renders the index page to show 3rd party apps the user needs to sign up for" do
      get :index

      expect(assigns(:user)).to eq(user)
      expect(response).to render_template(:index)
    end
  end
end
