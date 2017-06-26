require 'rails_helper'

describe Organizations::Onboarding::UsersController, :type => :controller do
  let(:organization) { FactoryGirl.create(:organization) }
  let(:user) { FactoryGirl.create(:user, organization: organization) }

  before do
    @request.host = "#{organization.subdomain}.myfirstshift.com"
    sign_in user
  end

  describe "#edit" do
    it "renders a form for the user to select different employment criteria" do
      get :edit

      expect(assigns(:user)).to eq(user)
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    context "successful params are submitted" do
      it "creates employment information for user" do
        patch :update, params: { user: { employee_type: "salary", phone: "123-456-7890" }}

        user.reload
        expect(user.employee_type).to eq("salary")
        expect(user.phone).to eq("123-456-7890")
        expect(response).to redirect_to(home_path)#onboarding_paperwork_overview_path)
      end
    end

    context "bad params are submitted" do
      it "returns the user to the employee info page" do
        patch :update, params: { user: { phone: "" }}

        expect(response).to render_template(:edit)
      end
    end
  end
end
