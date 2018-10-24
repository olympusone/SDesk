class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    data = Ticket.where("created_at > ?", Time.now.beginning_of_month)

    @tickets_count = data.group(:state).count
    @latest_tickets = data.limit(10)

    @chart_data = data.group("DAY(created_at)").count
  end
end
