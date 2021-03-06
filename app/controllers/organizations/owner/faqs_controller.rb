class Organizations::Owner::FaqsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner

  layout 'organizations/owner'

  def index
    faqs = @organization.faqs

    locals ({
      owner: current_user,
      faqs: faqs
    })
  end

  def create
    faq = @organization.faqs.build(faq_params)

    if faq.save
      if @organization.units.any?
        @organization.units.each do |unit|
          unit.faqs.build(faq_params)
          unit.save
        end
      end

      flash[:success] = "FAQ Added!"
      redirect_to owner_faqs_path
    else
      flash[:danger] = "There was an issue creating the FAQ, please try again"
      redirect_to owner_faqs_path
    end
  end

  def destroy
    faq = @organization.faqs.find(params[:id])

    if faq.delete
      flash[:success] = "FAQ Removed!"
      redirect_to owner_faqs_path
    else
      flash[:danger] = "There was a problem deleting the FAQ, please try again"
      redirect_to owner_faqs_path
    end
  end

  private

  def faq_params
    params.require(:faq).permit(:question, :answer)
  end
end
