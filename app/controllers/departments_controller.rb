class DepartmentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  add_breadcrumb I18n.t('activerecord.models.user.other')
  add_breadcrumb I18n.t('activerecord.models.department.other'), :departments_path

  def index
    respond_to do |format|
      format.html
      format.json {render json: DepartmentDatatable.new(view_context)}
    end
  end

  def new
    @department = Department.new

    render 'shared/js/modal', locals: {modal_name: 'edit'}
  end

  def create
    @department = Department.new(department_params)

    flash.now[:notice] = t('.success', value: @department.name) if @department.save
    render 'shared/js/save', locals: {resource: @department}
  end

  def edit
    @department = Department.find(params[:id])
    render 'shared/js/modal'
  end

  def update
    @department = Department.find(params[:id])

    flash.now[:notice] = t('.success', value: @department.name) if @department.update_attributes(department_params)
    render 'shared/js/save', locals: {resource: @department}
  end

  def destroy
    @department = Department.find(params[:id])

    if @department.destroy
      message = t('.success', value: @department.name)
      flash.now[:notice] = message
    else
      message = t('.error', value: @department.name)
      flash.now[:alert] = message
    end

    render 'shared/js/destroy'
  end

  private

  def department_params
    params.require(:department).permit(:name, :description)
  end
end
