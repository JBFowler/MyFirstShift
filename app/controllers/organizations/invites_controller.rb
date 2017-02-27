class Organizations::InvitesController < ApplicationController
  
  def show
    @user = User.new
  end

end