class CompaniesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  add_breadcrumb I18n.t('activerecord.models.requester.other')
  add_breadcrumb I18n.t('activerecord.models.company.other'), :companies_path

  def index
    respond_to do |format|
      format.html
      format.json {render json: CompanyDatatable.new(view_context)}
    end
  end

  def new
    @company = Company.new
    render :edit
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to companies_path, notice: t('.success', value: @company.name)
    else
      render :edit
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])

    if @company.update_attributes(company_params)
      redirect_to companies_path, notice: t('.success', value: @company.name)
    else
      render :edit
    end
  end

  def destroy
    @company = Company.find(params[:id])

    if @company.destroy
      message = t('.success', value: @company.name)
      flash.now[:notice] = message
    else
      message = t('.error', value: @company.name)
      flash.now[:alert] = message
    end

    render 'shared/js/destroy'
  end

  private
  def company_params
    params.require(:company).permit(:name, :address, :lat, :lng, :domain, :notes)
  end
end
