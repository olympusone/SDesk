class TicketReply < ApplicationRecord
  validates_presence_of :content

  belongs_to :ticket
  belongs_to :replier, polymorphic: true
end
