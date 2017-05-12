require 'rails_helper'

describe Admin::HomeController, :type => :controller do
  before do
    @request.host = "supernova.myfirstshift.com"
    @request.env['devise.mapping'] = Devise.mappings[:admin]
    sign_in admin
  end

  context "user is an admin" do
    let(:admin) { FactoryGirl.create(:admin) }

    describe "#index" do
      it "renders the index template" do
        get :index

        expect(response).to render_template(:index)
      end
    end
  end

  context "user is not an admin" do
    let(:admin) { FactoryGirl.create(:user) }

    describe "#index" do
      it "redirects user to sign in page" do
        get :index

        expect(response).to redirect_to(new_admin_session_path)
      end
    end
  end
end
