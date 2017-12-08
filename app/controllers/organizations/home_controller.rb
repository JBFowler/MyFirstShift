class Organizations::HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    fun_fact = FunFact.new

    locals ({
      fun_fact: fun_fact,
      user: current_user
    })
  end
end
