class Organizations::Owner::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    owner = current_user
    members = @organization.members.unscoped

    if params[:search]
      members = Services::User::FindUserService.search(members, params[:search]) unless params[:search].blank?
    end

    if params[:sort]
      members = members.order(params[:sort]) unless params[:sort].blank?
    end

    locals ({
      owner: current_user,
      members: members
    })
  end

  def show
    user = User.unscoped.find(params[:id])

    locals ({
      owner: current_user,
      user: user
    })
  end

  def edit
    user = User.find(params[:id])

    locals ({
      owner: current_user,
      user: user
    })
  end

  def update
    user = User.find(params[:id])

    if user.update(user_params)
      flash[:success] = "User has been updated!"
      redirect_to owner_member_path(user)
    else
      render :edit, locals: { user: user }
    end
  end

  def destroy
    user = User.find(params[:id])

    if user.destroy
      redirect_to owner_member_path(user)
    else
      flash[:danger] = "There was a problem deleting the user"
      redirect_to owner_member_path(user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :employee_type, :wage, :username, :phone)
  end
end
