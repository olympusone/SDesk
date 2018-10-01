class Requester < ApplicationRecord
  validates_presence_of :name, :lastname

  has_one :user, as: :user, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :ticket_replies, as: :replier, dependent: :destroy

  accepts_nested_attributes_for :user, update_only: true
end