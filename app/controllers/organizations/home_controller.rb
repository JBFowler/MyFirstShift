class Organizations::HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    new_fun_fact = FunFact.new
    old_fun_fact = current_user.fun_facts.sample

    locals ({
      new_fun_fact: new_fun_fact,
      old_fun_fact: old_fun_fact,
      user: current_user
    })
  end
end
