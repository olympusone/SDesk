class TicketsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: [:new, :create]

  add_breadcrumb I18n.t('activerecord.models.ticket.other'), :tickets_path

  def index
    respond_to do |format|
      format.html
      format.json {render json: TicketDatatable.new(view_context)}
    end
  end

  def new
    @ticket = Ticket.new

    @ticket.agent = current_user.user if user_signed_in? && current_user.role?(:agent)

    render :edit
  end

  def create
    @ticket = Ticket.new(ticket_params)

    if user_signed_in?
      @ticket.requester = current_user.user if current_user.role?(:requester)
    else
      @ticket.requester = Requester.includes(:user).references(:users).find_by(users: {email: @ticket.email})
    end

    if @ticket.save
      redirect_to (user_signed_in? ? tickets_path : new_ticket_path), notice: t('.success', value: @ticket.id)
    else
      @ticket.errors.add :email, :blank if @ticket.email.blank?
      render :edit
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])

    if @ticket.update_attributes(ticket_params)
      redirect_to tickets_path, notice: t('.success', value: @ticket.id)
    else
      render :edit
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])

    if @ticket.destroy
      message = t('.success', value: @ticket.id)
      flash.now[:notice] = message
    else
      message = t('.error', value: @ticket.id)
      flash.now[:alert] = message
    end

    render 'shared/js/destroy'
  end

  private

  def ticket_params
    if user_signed_in?
      if current_user.role? :requester
        params.require(:ticket).permit(:department_id, :subject, :priority, :description,
                                       file_attachments_attributes: [:id, :_destroy, :file])
      else
        params.require(:ticket).permit(:requester_id, :agent_id, :department_id, :priority, :state, :subject, :description,
                                       file_attachments_attributes: [:id, :_destroy, :file])
      end
    else
      params.require(:ticket).permit(:email, :department_id, :priority, :subject, :description,
                                     file_attachments_attributes: [:id, :_destroy, :file])
    end
  end
end
