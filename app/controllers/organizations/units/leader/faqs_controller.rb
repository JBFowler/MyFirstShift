class Organizations::Units::Leader::FaqsController < Organizations::Units::Leader::UnitLeadBaseController
  layout 'organizations/unit_leader'

  def create
    faq = @unit.faqs.build(faq_params)

    if faq.save
      flash[:success] = "FAQ Added!"
      redirect_to unit_leader_preferences_path
    else
      flash[:danger] = "There was an issue creating the FAQ, please try again"
      redirect_to unit_leader_preferences_path
    end
  end

  def destroy
    faq = @unit.faqs.find(params[:id])

    if @unit.faqs.delete(faq)
      flash[:success] = "FAQ Removed!"
      redirect_to unit_leader_preferences_path
    else
      flash[:danger] = "There was a problem deleting the FAQ, please try again"
      redirect_to unit_leader_preferences_path
    end
  end

  private

  def faq_params
    params.require(:faq).permit(:question)
  end
end
