require 'rails_helper'

describe Organizations::InvitesController, :type => :controller do
  let(:organization) { FactoryGirl.create(:organization) }
  let(:user) { FactoryGirl.create(:user, :owner, organization: organization) }

  before do
    @request.host = "#{organization.subdomain}.myfirstshift.com"
    sign_in user
  end

  describe "#show" do
    let(:invite) { FactoryGirl.create(:invite, :with_code, organization: organization) }

    it "renders the show action for a member to create account and join organization" do
      get :show, params: { id: invite.code }

      expect(assigns(:user)).to be_instance_of(User)
      expect(response).to render_template(:show)
    end
  end

end