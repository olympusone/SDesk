class Ticket < ApplicationRecord
  extend Enumerize

  after_create :new_ticket_email
  before_update :update_ticket_email

  PRIORITY = {low: 1, medium: 2, high: 3}
  STATE = {pending: 1, open: 2, closed: 3}

  enumerize :priority, in: PRIORITY, default: :low
  enumerize :state, in: STATE, default: :pending

  attr_accessor :email

  validates_presence_of :subject, :description
  validates_associated :agent, on: :update

  belongs_to :requester, validate: true
  belongs_to :agent, optional: true
  belongs_to :ticket_template, optional: true
  belongs_to :department, optional: true
  has_many :ticket_replies, dependent: :destroy
  has_many :file_attachments, as: :resource, dependent: :destroy

  accepts_nested_attributes_for :file_attachments, allow_destroy: true, reject_if: :all_blank, update_only: true

  default_scope {order created_at: :desc}

  private
  def new_ticket_email
    TicketMailer.new_ticket_email(self).deliver_later
  end

  def update_ticket_email
    if self.state_changed?
      if self.state == 'closed'
        TicketMailer.closed_ticket_email(self).deliver_later
      elsif self.state == 'open'
        TicketMailer.open_ticket_email(self).deliver_later
      end
    end
  end
end
