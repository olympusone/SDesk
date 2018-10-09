class Ticket < ApplicationRecord
  extend Enumerize

  PRIORITY = {low: 1, medium: 2, high: 3}
  STATE = {open: 1, pending: 2, closed: 3}

  enumerize :priority, in: PRIORITY, default: :low
  enumerize :state, in: STATE, default: :open

  attr_accessor :email

  validates_presence_of :subject, :description

  belongs_to :requester
  belongs_to :agent, optional: true
  belongs_to :ticket_template, optional: true
  belongs_to :department, optional: true
  has_many :ticket_replies, dependent: :destroy
  has_many :file_attachments, as: :resource, dependent: :destroy

  accepts_nested_attributes_for :file_attachments, allow_destroy: true, reject_if: :all_blank, update_only: true
end
