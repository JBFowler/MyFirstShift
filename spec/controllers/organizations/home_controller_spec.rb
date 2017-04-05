require 'rails_helper'

describe Organizations::HomeController, :type => :controller do
  let(:organization) { FactoryGirl.create(:organization) }
  let(:user) { FactoryGirl.create(:user, organization: organization) }

  before do
    @request.host = "#{organization.subdomain}.myfirstshift.com"
    sign_in user
  end

  describe "index" do
    it "shows member home page" do
      get :index

      expect(assigns(:user)).to eq(user)
      expect(assigns(:organization)).to eq(organization)
      expect(response).to render_template(:index)
    end
  end
end
