class SolutionCategory < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitive: false}

  has_many :solution_folders, dependent: :destroy

  default_scope {order :name}
end
