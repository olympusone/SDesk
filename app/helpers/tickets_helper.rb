module TicketsHelper
  def setup_ticket ticket
    ticket.file_attachments || ticket.file_attachments.build
    ticket
  end
end
