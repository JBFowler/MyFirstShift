class Admin::OrganizationsController < Admin::BaseController
  before_action :get_organization, only: [:show, :edit, :update]

  def index
    @organizations = Organization.unscoped
  end

  def show
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      flash[:success] = "#{@organization.name} was successfully created"
      redirect_to admin_organization_path(@organization)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @organization.update(organization_params)
      flash[:success] = "#{@organization.name} has been updated"
      redirect_to admin_organization_path(@organization)
    else
      render :edit
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :size, :sector, :subdomain)
  end

  def get_organization
    @organization = Organization.unscoped.find(params[:id])
  end
end
