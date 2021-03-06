require 'rails_helper'

describe FrontController, :type => :controller do
  before do
    @request.host = "myfirstshift.com"
  end

  it "displays the front page to either register or login" do
    get :index

    expect(response).to render_template(:layout => "front")
    expect(response).to render_template(:index)
  end
end
