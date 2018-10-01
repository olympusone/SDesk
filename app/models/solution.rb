class Solution < ApplicationRecord
  validates :title, presence: true, uniqueness: {case_sensitive: false}
  validates_associated :solution_folder

  belongs_to :solution_folder
end
