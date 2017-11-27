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
    units = @organization.cached_units

    locals ({
      owner: current_user,
      user: user,
      units: units
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
      respond_to do |format|
        format.json { render json: { message: "#{user.full_name} has been updated!" }.to_json }
        format.html do
          flash[:success] = "#{user.full_name} has been updated!"
          redirect_to owner_member_path(user)
        end
      end
    else
      respond_to do |format|
        format.html { render :edit, locals: { owner: current_user, user: user } }
        format.json { render json: user.errors.full_messages.to_json, status: 400 }
      end
    end
  end

  def add_unit
    user = @organization.members.friendly.find(params[:user_id])
    unit = @organization.units.friendly.find(params[:unit_id])

    if user.join_unit!(unit)
      flash[:success] = "#{user.full_name} added to #{unit.name}"
      redirect_to owner_member_path(user)
    else
      flash.now[:warning] = "#{user.full_name} is already a part of #{unit.name}"
      render :show, locals: { owner: current_user, user: user }
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
    params.require(:user).permit(:first_name, :last_name, :email, :employee_type, :wage, :username, :phone, :role, :e_verified, :state_verified)
  end
end
