class SolutionFoldersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  add_breadcrumb I18n.t('solutions.knowledge_base.index')
  add_breadcrumb I18n.t('activerecord.models.solution_folder.other'), :solution_folders_path

  def index
    respond_to do |format|
      format.html
      format.json {render json: SolutionFolderDatatable.new(view_context)}
    end
  end

  def new
    @solution_folder = SolutionFolder.new

    render 'shared/js/modal', locals: {modal_name: 'edit'}
  end

  def create
    @solution_folder = SolutionFolder.new(solution_folder_params)

    flash.now[:notice] = t('.success', value: @solution_folder.name) if @solution_folder.save
    render 'shared/js/save', locals: {resource: @solution_folder}
  end

  def edit
    @solution_folder = SolutionFolder.find(params[:id])
    render 'shared/js/modal'
  end

  def update
    @solution_folder = SolutionFolder.find(params[:id])

    flash.now[:notice] = t('.success', value: @solution_folder.name) if @solution_folder.update_attributes(solution_folder_params)
    render 'shared/js/save', locals: {resource: @solution_folder}
  end

  def destroy
    @solution_folder = SolutionFolder.find(params[:id])

    if @solution_folder.destroy
      message = t('.success', value: @solution_folder.name)
      flash.now[:notice] = message
    else
      message = t('.error', value: @solution_folder.name)
      flash.now[:alert] = message
    end

    render 'shared/js/destroy'
  end

  private

  def solution_folder_params
    params.require(:solution_folder).permit(:name, :description, :solution_category_id)
  end
end
