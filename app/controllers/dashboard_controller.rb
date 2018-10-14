class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @tickets_count = Ticket.where("MONTH(created_at) = #{Date.current.month}").group(:state).count
    @latest_tickets = Ticket.limit(10)
  end
end
