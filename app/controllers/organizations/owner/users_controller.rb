class Organizations::Owner::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    members = @organization.members.with_deleted

    if params[:search]
      members = ::Services::User::FindUserService.search(members, params[:search]) unless params[:search].blank?
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
    user = @organization.members.friendly.with_deleted.find(params[:id])

    locals ({
      owner: current_user,
      user: user
    })
  end

  def edit
    user = @organization.members.friendly.find(params[:id])

    locals ({
      owner: current_user,
      user: user
    })
  end

  def update
    user = @organization.members.friendly.find(params[:id])

    if user.update(user_params)
      flash[:success] = "#{user.full_name} has been updated!"
      redirect_to owner_member_path(user)
    else
      render :edit, locals: { owner: current_user, user: user }
    end
  end

  def destroy
    user = @organization.members.friendly.find(params[:id])

    if user.destroy
      redirect_to owner_member_path(user)
    else
      flash[:danger] = "There was a problem deleting the user"
      redirect_to owner_member_path(user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :employee_type, :wage, :username, :phone, :role)
  end
end
