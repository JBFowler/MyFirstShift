class Organizations::Users::FunFactsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = current_user
    fun_fact = current_user.fun_facts.new(fun_fact_params)

    if fun_fact.save
      respond_to do |format|
        format.js { render locals: { fun_fact: fun_fact } }
      end
    else
      respond_to do |format|
        format.js { render locals: { fun_fact: fun_fact } }
      end
    end
  end

  def update
    user = current_user
    fun_fact = current_user.fun_facts.find(params[:id])

    if fun_fact.update(fun_fact_params)
      respond_to do |format|
        format.js { render locals: { fun_fact: fun_fact } }
      end
    else
      respond_to do |format|
        format.js { render locals: { fun_fact: fun_fact } }
      end
    end
  end

  private

  def fun_fact_params
    params.require(:fun_fact).permit(:question, :answer)
  end
end
