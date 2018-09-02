class TicketRepliesController < ApplicationController
  load_and_authorize_resource :ticket_reply

  before_action :authenticate_ticket_reply!

  def index
    respond_to do |format|
      format.html
      format.json { render json: TicketReplyDatatable.new(view_context) }
    end
  end

  def new
    @ticket_reply = TicketReply.new
  end

  def create
    @ticket_reply = TicketReply.new(ticket_reply_params)

    if @ticket_reply.save
      redirect_to ticket_replies_path, notice: t('.success', value: @ticket_reply.name)
    else
      render :new
    end
  end

  def edit
    @ticket_reply = TicketReply.find(params[:id])
  end

  def update
    @ticket_reply = TicketReply.find(params[:id])

    if update_resource(@ticket_reply, ticket_reply_params)
      redirect_to ticket_replies_path, notice: t('.success', value: @ticket_reply.name)
    else
      render :edit
    end
  end

  def destroy
    @ticket_reply = TicketReply.find(params[:id])

    respond_to do |format|
      if @ticket_reply.destroy
        message = t('.success', value: @ticket_reply.name)

        format.html{ redirect_to ticket_replies_path, notice: message }
        format.js do
          flash.now[:notice] = message
          render 'shared/js/destroy'
        end
      else
        message = t('.error', value: @ticket_reply.name)
        format.html{ redirect_to ticket_replies_path, notice: message }
        format.js do
          flash.now[:alert] = message
          render 'shared/js/destroy'
        end
      end
    end
  end

  private
  def ticket_reply_params
    params.require(:ticket_reply).permit(:name, )
  end
end
