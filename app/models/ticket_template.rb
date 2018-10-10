class TicketTemplate < ApplicationRecord
  extend Enumerize

  enumerize :priority, in: Ticket::PRIORITY, default: :low
  enumerize :state, in: Ticket::STATE, default: :pending

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates_presence_of :subject, :description

  belongs_to :agent, optional: true
  belongs_to :department, optional: true

  default_scope {order :name}
end
