require 'rails_helper'

describe Organizations::Owner::InvitesController, :type => :controller do
  let(:organization) { FactoryGirl.create(:organization) }
  let(:user) { FactoryGirl.create(:user, :owner, organization: organization) }

  before do
    @request.host = "#{organization.subdomain}.myfirstshift.com"
    sign_in user
  end

  describe "#new" do
    it "should render the new template" do
      get :new

      expect(assigns(:invite)).to be_instance_of(Invite)
      expect(response).to render_template(:new) 
    end
  end

end