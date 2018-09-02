class TicketTemplate < ApplicationRecord
  extend Enumerize

  enumerize :priority, in: Ticket::PRIORITY, default: :low
  enumerize :state, in: Ticket::STATE, default: :waiting

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates_presence_of :subject, :description

  belongs_to :requester
  belongs_to :agent, optional: true
  belongs_to :ticket_template, optional: true
  belongs_to :department, optional: true
  has_many :ticket_replies, dependent: :destroy
end
