require 'rails_helper'

describe Organizations::Onboarding::UsersController, :type => :controller do
  let(:organization) { FactoryGirl.create(:organization) }
  let(:user) { FactoryGirl.create(:user, organization: organization) }

  before do
    @request.host = "#{organization.subdomain}.myfirstshift.com"
    sign_in user
  end

  describe "#complete" do
    it "sets the users progress to complete and redirects to the home page" do
      user.update(employee_type: "salary", phone: "000-000-0000")

      get :complete

      user.reload
      expect(assigns(:user)).to eq(user)
      expect(user.progress_complete?).to eq(true)
      expect(response).to redirect_to(home_path)
    end
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
        expect(response).to redirect_to(onboarding_paperwork_path)
      end
    end

    context "bad params are submitted" do
      it "returns the user to the employee info page" do
        patch :update, params: { user: { phone: "" }}

        user.reload
        expect(user.employee_type).to eq(nil)
        expect(user.phone).to eq(nil)
        expect(response).to render_template(:edit)
      end
    end
  end
end
