class TicketsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: [:new, :create]

  def index
    respond_to do |format|
      format.html
      format.json { render json: TicketDatatable.new(view_context) }
    end
  end

  def new
    @ticket = Ticket.new
  end

  def create
    if Requester.includes(:user).references(:users).exists?(users:{email: params[:ticket][:email]})

    else
      render :new, alert: 'Email address is not belongs to any user.'
    end
  end

  private
  def ticket_params
    if current_user.role? :requester
      params.require(:ticket).permit(:requester_id, :department_id, :subject, :description,
                                     file_attachments_attributes:[:id, :_destroy, :file])
    else
      params.require(:ticket).permit(:requester_id, :agent_id, :department_id, :priority, :state, :tags, :subject, :description,
                                     file_attachments_attributes:[:id, :_destroy, :file])
    end
  end
end
