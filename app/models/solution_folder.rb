class SolutionFolder < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates_associated :solution_category

  has_many :solutions, dependent: :destroy
  belongs_to :solution_category

  default_scope {order :name}
end
