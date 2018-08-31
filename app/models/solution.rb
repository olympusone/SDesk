class Solution < ApplicationRecord
  validates :title, presence: true, uniqueness: {case_sensitive: false}

  belongs_to :solution_folder
end
