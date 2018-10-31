class TicketTemplatesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: :show

  add_breadcrumb I18n.t('settings.index.title')
  add_breadcrumb I18n.t('activerecord.models.ticket_template.other'), :ticket_templates_path

  def index
    respond_to do |format|
      format.html
      format.json {render json: TicketTemplateDatatable.new(view_context)}
    end
  end

  def new
    @ticket_template = TicketTemplate.new
    render :edit
  end

  def create
    @ticket_template = TicketTemplate.new(ticket_template_params)

    if @ticket_template.save
      redirect_to ticket_templates_path, notice: t('.success', value: @ticket_template.name)
    else
      render :edit
    end
  end

  def show
    ticket_template = TicketTemplate.find(params[:id])

    render json:{ ticket_template: ticket_template }
  end

  def edit
    @ticket_template = TicketTemplate.find(params[:id])
  end

  def update
    @ticket_template = TicketTemplate.find(params[:id])

    if @ticket_template.update_attributes(ticket_template_params)
      redirect_to ticket_templates_path, notice: t('.success', value: @ticket_template.name)
    else
      render :edit
    end
  end

  def destroy
    @ticket_template = TicketTemplate.find(params[:id])

    if @ticket_template.destroy
      message = t('.success', value: @ticket_template.name)
      flash.now[:notice] = message
    else
      message = t('.error', value: @ticket_template.name)
      flash.now[:alert] = message
    end

    render 'shared/js/destroy'
  end

  private

  def ticket_template_params
    params.require(:ticket_template).permit(:name, :active, :subject, :description, :priority, :state, :agent_id,
                                    :department_id)
  end
end
