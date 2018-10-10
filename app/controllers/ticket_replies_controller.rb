class TicketRepliesController < ApplicationController
  load_and_authorize_resource :ticket_reply
  before_action :authenticate_user!

  def new
    @ticket = Ticket.find(params[:ticket_id])
    @ticket_reply = @ticket.ticket_replies.build
  end

  def create
    @ticket = Ticket.find(params[:ticket_id])
    @ticket_reply = @ticket.ticket_replies.build(ticket_reply_params)

    @ticket_reply.replier = current_user.user

    if @ticket_reply.save
      flash.now[:notice] = t('.success')
    else
      flash.now[:notice] = t('.error')
    end
  end

  private
  def ticket_reply_params
    params.require(:ticket_reply).permit(:content)
  end
end
