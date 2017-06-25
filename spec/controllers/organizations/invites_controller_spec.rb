require 'rails_helper'

describe Organizations::InvitesController, :type => :controller do
  let(:organization) { FactoryGirl.create(:organization) }
  let(:invite) { FactoryGirl.create(:invite, :with_code, organization: organization) }

  before do
    @request.host = "#{organization.subdomain}.myfirstshift.com"
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "#show" do
    it "renders the show action for a member to create account and join organization" do
      get :show, params: { id: invite.code }

      expect(assigns(:user)).to be_instance_of(User)
      expect(response).to render_template(:show)
    end

    context "the invite is expired" do
      let(:expired_invite) { FactoryGirl.build(:invite, :with_code, organization: organization, expires_at: 1.day.ago)}
      it "renders the show action for a member to create account and join organization" do
        expired_invite.save(validate: false)

        get :show, params: { id: expired_invite.code }

        expect(flash[:warning]).to eq("This invitation has already been redeemed or has expired")
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "the invite has already been redeemed" do
      let(:redeemed_invite) { FactoryGirl.build(:invite, :with_code, :redeemed, organization: organization)}
      it "renders the show action for a member to create account and join organization" do
        get :show, params: { id: redeemed_invite.code }

        expect(flash[:warning]).to eq("This invitation has already been redeemed or has expired")
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "#redeem" do
    context "with valid params" do
      let(:valid_user_params) { FactoryGirl.attributes_for(:user) }

      it "creates a user and joins user to organization" do
        post :redeem, params: { id: invite.code, user: valid_user_params }

        user = User.first
        invite.reload

        expect(User.all.count).to eq(1)
        expect(organization.users).to eq([user])
        expect(user.role).to eq("member")
        expect(user.email).to eq(invite.email)
        expect(invite.redeemed_at).to_not be_nil
        expect(invite.redeemed_by).to eq(user.id)
        expect(flash[:success]).to eq("Your profile was successfully created")
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
