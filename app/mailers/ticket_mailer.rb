class TicketMailer < ApplicationMailer
  def new_ticket_email ticket
    @requester = ticket.requester
    @ticket = ticket

    mail(to: @requester.user.email, subject: 'Your ticket is submitted successfully!'.html_safe,
         delivery_method_options: app_smtp_settings)
  end

  def open_ticket_email ticket
    @requester = ticket.requester
    @ticket = ticket

    mail(to: @requester.user.email, subject: "A ticket No:#{@ticket.id} is opened!".html_safe,
         delivery_method_options: app_smtp_settings)
  end

  def closed_ticket_email ticket
    @requester = ticket.requester
    @ticket = ticket

    mail(to: @requester.user.email, subject: "A ticket No: #{@ticket.id} has closed!".html_safe,
         delivery_method_options: app_smtp_settings)
  end

  def ticket_reply_email ticket_reply
    @ticket_reply = ticket_reply
    @ticket = @ticket_reply.ticket
    @requester = @ticket.requester

    mail(to: @requester.user.email, subject: "New reply on ticket No: #{@ticket.id} has submitted!".html_safe,
         delivery_method_options: app_smtp_settings)
  end
end
