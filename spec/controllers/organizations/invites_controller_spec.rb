require 'rails_helper'

describe Organizations::InvitesController, :type => :controller do
  let(:organization) { FactoryGirl.create(:organization) }
  let(:invite) { FactoryGirl.create(:invite, :with_code, organization: organization) }

  before do
    @request.host = "#{organization.subdomain}.myfirstshift.com"
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "#show" do
    let(:user) { FactoryGirl.create(:user, :owner, organization: organization) }

    it "renders the show action for a member to create account and join organization" do
      sign_in user

      get :show, params: { id: invite.code }

      expect(assigns(:user)).to be_instance_of(User)
      expect(response).to render_template(:show)
    end
  end

  describe "#redeem" do
    context "with valid params" do
      let(:valid_user_params) { FactoryGirl.attributes_for(:user) }

      it "creates a user and joins user to organization" do
        post :redeem, params: { id: invite.code, user: valid_user_params }

        user = User.first
        invite = Invite.first

        expect(User.all.count).to eq(1)
        expect(organization.users).to eq([user])
        expect(user.role).to eq("member")
        expect(user.email).to eq(invite.email)
        expect(invite.redeemed_at).to_not be_nil
        expect(invite.redeemed_by).to eq(user.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "with invalid params" do
      let(:invalid_user_params) { FactoryGirl.attributes_for(:user, password: "", password_confirmation: "wrong password") }

      it "renders the show template with errors" do
        post :redeem, params: { id: invite.code, user: invalid_user_params }

        expect(User.all.count).to eq(0)
        expect(response).to render_template(:show)
      end
    end
  end

end