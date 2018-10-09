class SolutionsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  add_breadcrumb I18n.t('solutions.knowledge_base.index')
  add_breadcrumb I18n.t('activerecord.models.solution.other'), :solutions_path

  def index
    respond_to do |format|
      format.html
      format.json {render json: SolutionDatatable.new(view_context)}
    end
  end

  def new
    @solution = Solution.new
    render :edit
  end

  def create
    @solution = Solution.new(solution_params)

    if @solution.save
      redirect_to solutions_path, notice: t('.success', value: @solution.title)
    else
      render :edit
    end
  end

  def edit
    @solution = Solution.find(params[:id])
  end

  def update
    @solution = Solution.find(params[:id])

    if @solution.update_attributes(solution_params)
      redirect_to solutions_path, notice: t('.success', value: @solution.title)
    else
      render :edit
    end
  end

  def destroy
    @solution = Solution.find(params[:id])

    if @solution.destroy
      message = t('.success', value: @solution.title)
      flash.now[:notice] = message
    else
      message = t('.error', value: @solution.title)
      flash.now[:alert] = message
    end

    render 'shared/js/destroy'
  end

  private

  def solution_params
    params.require(:solution).permit(:title, :solution_folder_id, :tags, :content,
                                     file_attachments_attributes:[:id, :_destroy, :file])
  end
end
