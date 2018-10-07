class Department < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitive: false}

  has_many :agents, dependent: :restrict_with_error

  default_scope {order :name}
end
