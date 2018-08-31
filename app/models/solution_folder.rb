class SolutionFolder < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitive: false}

  has_many :solutions, dependent: :destroy
  belongs_to :solution_category
end
