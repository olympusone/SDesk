class TicketReply < ApplicationRecord
  after_create :send_email

  validates_presence_of :content

  belongs_to :ticket, validate: true
  belongs_to :replier, polymorphic: true, validate: true

  private
  def send_email
    TicketMailer.ticket_reply_email(self).deliver_later unless self.replier.is_a? Requester
  end
end
