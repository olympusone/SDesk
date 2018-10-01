class Admin < ApplicationRecord
  validates_presence_of :name, :lastname

  has_one :user, as: :user, dependent: :destroy

  accepts_nested_attributes_for :user, update_only: true

  def fullname
    "#{self.name} #{self.fullname}"
  end
end
