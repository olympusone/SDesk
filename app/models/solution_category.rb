class SolutionCategory < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitive: false}

  has_many :solution_folders, dependent: :destroy
end
