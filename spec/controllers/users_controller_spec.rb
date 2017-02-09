require 'rails_helper'

describe UsersController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  
  describe "GET #show" do
    it "renders the users show page" do
      get :show, id: user.id

      expect(assigns(:user)).to eq(user)
      expect(response).to render_template(:show)
    end
  end
end