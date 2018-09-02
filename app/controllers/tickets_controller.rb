class TicketsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: [:new, :create]

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
    # TODO ean to role einai :user tote na dinei sigkekrimena attributes, oxi ola
    params.require(:ticket).permit(:subject, :description, attachemnts:[])
  end
end
