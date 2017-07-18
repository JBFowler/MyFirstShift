require 'rails_helper'

describe Organizations::Owner::HomeController, :type => :controller do
  let(:organization) { FactoryGirl.create(:organization) }
  let(:user) { FactoryGirl.create(:user, :owner, organization: organization) }

  before do
    @request.host = "#{organization.subdomain}.myfirstshift.com"
    sign_in user
  end

  describe "#index" do
    it "shows admin home page" do
      get :index

      expect(assigns(:user)).to eq(user)
      expect(assigns(:organization)).to eq(organization)
      expect(response).to render_template(:index)
    end
  end

end
