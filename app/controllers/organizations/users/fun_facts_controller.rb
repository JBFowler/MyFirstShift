class Organizations::Users::FunFactsController < ApplicationController
  before_action :authenticate_user!

  def index
    locals ({
      user: current_user
    })
  end
end
