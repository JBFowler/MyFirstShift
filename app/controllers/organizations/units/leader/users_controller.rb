class Organizations::Units::Leader::UsersController < Organizations::Units::Leader::UnitLeadBaseController
  layout 'organizations/unit_leader'

  def index
    members = @unit.members.with_deleted

    if params[:search]
      members = ::Services::User::FindUserService.search(members, params[:search]) unless params[:search].blank?
    end

    if params[:sort]
      members = members.order(params[:sort]) unless params[:sort].blank?
    else
      members = members.order(:last_name)
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

    if user_params[:role].blank?
      if user.update(user_params)
        respond_to do |format|
          format.json { render json: { message: "#{user.full_name} has been updated!" }.to_json }
          format.html do
            flash[:success] = "#{user.full_name} has been updated!"
            redirect_to unit_leader_member_path(@unit, user)
          end
        end
      else
        respond_to do |format|
          format.html { render :edit, locals: { unit_leader: current_user, user: user } }
          format.json { render json: { messages: user.errors.full_messages.to_json }, status: 400 }
        end
      end
    else
      user.role = user_params[:role]

      if user.save(validate: false)
        flash[:success] = "#{user.full_name}'s role has been changed to #{user_params[:role].humanize}!"
        redirect_to unit_leader_member_path(@unit, user)
      else
        render :edit, locals: { unit_leader: current_user, user: user }
      end
    end
  end

  def destroy
    user = @unit.members.friendly.find(params[:id])

    if user.delete
      redirect_to unit_leader_member_path(@unit, user)
    else
      flash[:danger] = "There was a problem deleting the user"
      redirect_to unit_leader_member_path(@unit, user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :employee_type, :wage, :username, :phone, :role, :e_verified, :state_verified, :date_of_birth, :ssn, :drivers_license_number, :drivers_license_expiration, :passport_number, :passport_expiration)
  end
end
