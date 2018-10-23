class Agent < ApplicationRecord
  validates_presence_of :name, :lastname

  has_one :user, as: :user, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :ticket_replies, as: :replier
  belongs_to :department, validate: true

  accepts_nested_attributes_for :user, update_only: true

  default_scope {order :name, :lastname}

  def fullname
    "#{self.name} #{self.lastname}"
  end
end
