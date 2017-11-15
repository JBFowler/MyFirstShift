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

      expect(response).to render_template(:index)
    end
  end

  describe "#show" do
    it "shows an individual user page" do
      get :show, params: { id: user.id }

      expect(response).to render_template(:show)
    end
  end

  describe "#edit" do
    it "shows edit page for individual user" do
      get :edit, params: { id: user.id }

      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    context "when the update is successful" do
      it "updates the fields for a user" do
        put :update, params: { id: user.id, user: { phone: '111-111-1111', wage: 3.00, email: 'example@example.com1', employee_type: 'salary'}}

        user.reload
        expect(user.phone).to eq('111-111-1111')
        expect(user.wage).to eq(3.00)
        expect(user.email).to eq('example@example.com1')
        expect(user.employee_type).to eq('salary')
        expect(flash[:success]).to eq('User has been updated!')
        expect(response).to redirect_to(owner_member_path(user))
      end
    end

    context "when there are errors with the update" do
      it "returns to the edit page and displays the errors" do
        put :update, params: { id: user.id, user: { phone: '111-111-1111', wage: 3.00, email: 'example@example.com1'}}

        expect(response).to render_template(:edit)
      end
    end
  end

  describe "#delete" do
    it "soft deletes the user" do
      delete :destroy, params: { id: user.id }

      user.reload
      expect(user.deleted_at).to_not be_nil
      expect(response).to redirect_to(owner_member_path(user))
    end
  end
end
