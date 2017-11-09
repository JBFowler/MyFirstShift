require 'rails_helper'

describe Organizations::Owner::UsersController, :type => :controller do
  let(:organization) { FactoryGirl.create(:organization) }
  let(:user) { FactoryGirl.create(:user, :owner, organization: organization) }

  before do
    @request.host = "#{organization.subdomain}.myfirstshift.com"
    sign_in user
  end

  describe "#index" do
    it "shows users page" do
      get :index

      expect(assigns(:owner)).to eq(user)
      expect(assigns(:organization)).to eq(organization)
      expect(assigns(:members)).to eq(organization.members)
      expect(response).to render_template(:index)
    end
  end
end
