class Admin < ApplicationRecord
  validates_presence_of :name, :lastname

  has_one :user, as: :user, dependent: :destroy
  has_many :ticket_replies, as: :replier

  accepts_nested_attributes_for :user, update_only: true

  default_scope {order :lastname, :name}

  def fullname
    "#{self.name} #{self.lastname}"
  end
end
