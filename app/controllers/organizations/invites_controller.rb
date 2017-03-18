class Organizations::InvitesController < Devise::RegistrationsController
  before_action :set_invite
  before_action :check_redeemed

  def show
    @user = User.new
  end

  def redeem
    organization = @invite.organization
    @user = organization.users.build(user_params)
    @user.assign_attributes(subdomain: organization.subdomain, email: @invite.email, role: "member")

    @user.save
    if @user.persisted?
      if @user.active_for_authentication?
        @invite.redeem(@user)

        flash[:success] = "Your profile was successfully created"
        redirect_to new_user_session_path
      end
    else
      clean_up_passwords(@user)
      render :show
    end
  end

  private

  def set_invite
    @invite = Invite.find_by(code: params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :password, :password_confirmation)
  end

  def check_redeemed
    if @invite.redeemed_at?
      flash[:warning] = "This invitation has already been redeemed"
      redirect_to new_user_session_path
    end
  end
end
