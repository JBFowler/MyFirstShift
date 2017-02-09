require 'rails_helper'

describe RegistrationsController, :type => :controller do
  let(:valid_user_params) { {first_name: "Joe", last_name: "Test", email: "joetest@example.com", username: "joetest", password: "password"} }
  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST #create" do
    context "when there are valid params present" do
      it "creates a user" do
        post :create, user: valid_user_params

        expect(User.all.count).to eq(1)
        expect(flash[:success]).to eq("Your profile was successfully created")
        expect(response).to redirect_to root_path(User.first)
      end
    end

    context "when the user has invalid params" do
      it "renders the new template with validation errors" do
        post :create, user: {first_name: "Joe"}

        expect(User.all.count).to eq(0)
        expect(response).to render_template(:new)
      end
    end
  end
end