class Organizations::Units::Leader::UsersController < Organizations::Units::Leader::UnitLeadBaseController
  layout 'organizations/unit_leader'

  def index
    members = @unit.members.with_deleted

    if params[:search]
      members = ::Services::User::FindUserService.search(members, params[:search]) unless params[:search].blank?
    end

    if params[:sort]
      members = members.order(params[:sort]) unless params[:sort].blank?
    end

    locals ({
      unit_leader: current_user,
      members: members
    })
  end

  def show
    user = @unit.members.friendly.with_deleted.find(params[:id])

    locals ({
      unit_leader: current_user,
      user: user
    })
  end

  def edit
    user = @unit.members.friendly.find(params[:id])

    locals ({
      unit_leader: current_user,
      user: user
    })
  end

  def update
    user = @unit.members.friendly.find(params[:id])

    if user.update(user_params)
      flash[:success] = "#{user.full_name} has been updated!"
      redirect_to unit_leader_member_path(@unit, user)
    else
      render :edit, locals: { unit_leader: current_user, user: user }
    end
  end

  def destroy
    user = @unit.members.friendly.find(params[:id])

    if user.destroy
      redirect_to unit_leader_member_path(@unit, user)
    else
      flash[:danger] = "There was a problem deleting the user"
      redirect_to unit_leader_member_path(@unit, user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :employee_type, :wage, :username, :phone, :role)
  end
end
