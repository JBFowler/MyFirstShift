# require 'rails_helper'

# describe Organizations::Onboarding::OnboardingController, :type => :controller do
#   let(:organization) { FactoryGirl.create(:organization) }
#   let(:user) { FactoryGirl.create(:user, organization: organization) }

#   before do
#     @request.host = "#{organization.subdomain}.myfirstshift.com"
#     sign_in user
#   end

#   describe "#meet_the_management" do
#     it "shows the management of the organization you are working for" do
#       get :meet_the_management

#       expect(assigns(:user)).to eq(user)
#       expect(response).to render_template(:meet_the_management)
#     end
#   end

#   describe "#employee_info" do
#     it "renders a form for the user to select different employment criteria" do
#       get :employee_info

#       expect(assigns(:user)).to eq(user)
#       expect(response).to render_template(:employee_info)
#     end
#   end

#   describe "#add_employmee_info" do
#     context "successful params are submitted" do
#       it "creates employment information for user" do
#         post :add_employee_info, params: { employee_type: "salary", phone: "123-456-7890" }

#         expect(user.employee_type).to eq("salary")
#         expect(user.phone).to eq("123-456-7890")
#         expect(response).to redirect_to(onboarding_paperwork_overview_path)
#       end
#     end

#     context "bad params are submitted" do
#       it "returns the user to the employee info page" do
#         post :add_employee_info, params: { phone: "" }

#         # expect(user.errors).to eq()
#         expect(response).to render_template(:employee_info)
#       end
#     end
#   end
# end
