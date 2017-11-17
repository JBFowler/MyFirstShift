require 'rails_helper'

describe Organizations::Owner::UnitsController, :type => :controller do
  let(:organization) { FactoryGirl.create(:organization) }
  let(:user) { FactoryGirl.create(:user, :owner, organization: organization) }
  let(:unit) { FactoryGirl.create(:unit, organization: organization, created_by: user) }

  before do
    @request.host = "#{organization.subdomain}.myfirstshift.com"
    sign_in user
  end

  describe "#index" do
    it "shows list of all units" do
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe "#show" do
    it "shows an individual unit page" do
      get :show, params: { id: unit.id }

      expect(response).to render_template(:show)
    end
  end

  describe "#new" do
    it "shows a form to create a new unit" do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe "#edit" do
    it "shows edit page for individual unit" do
      get :edit, params: { id: unit.id }

      expect(response).to render_template(:edit)
    end
  end

  describe "#create" do
    context "when valid params are present" do
      it "creates a unit and then displays the unit show page" do
        post :create, params: { unit: { name: 'Test Unit', city: 'Houston', state: 'TX' }}

        expect(Unit.all.count).to eq(1)
        expect(Unit.first.created_by).to eq(user)
        expect(flash[:success]).to eq("Unit Created!")
        expect(response).to redirect_to(owner_unit_path(Unit.first))
      end
    end

    context "when invalid params are present" do
      it "renders the new template with errors" do
        post :create, params: { unit: { name: "" }}

        expect(Unit.all.count).to eq(0)
        expect(response).to render_template(:new)
      end
    end

    context "when an identical unit is created" do
      it "renders the new template with errors" do
        FactoryGirl.create(:unit, name: 'Test Unit', city: 'Houston', state: 'TX', created_by: user)

        post :create, params: { unit: { name: 'Test Unit', city: 'Houston', state: 'TX' }}

        expect(Unit.all.count).to eq(1)
        expect(response).to render_template(:new)
      end
    end
  end


  # describe "#update" do
  #   context "when the update is successful" do
  #     it "updates the fields for a unit" do
  #       put :update, params: { id: unit.id, unit: { phone: '111-111-1111', wage: 3.00, email: 'example@example.com1', employee_type: 'salary'}}

  #       unit.reload
  #       expect(unit.phone).to eq('111-111-1111')
  #       expect(unit.wage).to eq(3.00)
  #       expect(unit.email).to eq('example@example.com1')
  #       expect(unit.employee_type).to eq('salary')
  #       expect(flash[:success]).to eq('unit has been updated!')
  #       expect(response).to redirect_to(owner_member_path(unit))
  #     end
  #   end

  #   context "when there are errors with the update" do
  #     it "returns to the edit page and displays the errors" do
  #       put :update, params: { id: unit.id, unit: { phone: '111-111-1111', wage: 3.00, email: 'example@example.com1'}}

  #       expect(response).to render_template(:edit)
  #     end
  #   end
  # end

  # describe "#delete" do
  #   it "soft deletes the unit" do
  #     delete :destroy, params: { id: unit.id }

  #     unit.reload
  #     expect(unit.deleted_at).to_not be_nil
  #     expect(response).to redirect_to(owner_member_path(unit))
  #   end
  # end
end
