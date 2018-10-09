class TicketMailer < ApplicationMailer
  def new_ticket_email ticket
    @requester = ticket.requester
    @ticket = ticket

    mail(to: @requester.user.email, subject: 'Your ticket is submitted successfully!'.html_safe)
  end

  def open_ticket_email ticket
    @requester = ticket.requester
    @ticket = ticket

    mail(to: @requester.user.email, subject: "A ticket No:#{@ticket.id} is opened!".html_safe)
  end

  def closed_ticket_email ticket
    @requester = ticket.requester
    @ticket = ticket

    mail(to: @requester.user.email, subject: "A ticket No: #{@ticket.id} has closed!".html_safe)
  end
end
