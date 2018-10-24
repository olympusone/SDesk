class SolutionCategoriesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html
      format.json {render json: SolutionCategoryDatatable.new(view_context)}
    end
  end

  def new
    @solution_category = SolutionCategory.new

    render 'shared/js/modal', locals: {modal_name: 'edit'}
  end

  def create
    @solution_category = SolutionCategory.new(solution_category_params)

    flash.now[:notice] = t('.success', value: @solution_category.name) if @solution_category.save
    render 'shared/js/save', locals: {resource: @solution_category}
  end

  def edit
    @solution_category = SolutionCategory.find(params[:id])
    render 'shared/js/modal'
  end

  def update
    @solution_category = SolutionCategory.find(params[:id])

    flash.now[:notice] = t('.success', value: @solution_category.name) if @solution_category.update_attributes(solution_category_params)
    render 'shared/js/save', locals: {resource: @solution_category}
  end

  def destroy
    @solution_category = SolutionCategory.find(params[:id])

    if @solution_category.destroy
      message = t('.success', value: @solution_category.name)
      flash.now[:notice] = message
    else
      message = t('.error', value: @solution_category.name)
      flash.now[:alert] = message
    end

    render 'shared/js/destroy'
  end

  private

  def solution_category_params
    params.require(:solution_category).permit(:name, :description)
  end
end
