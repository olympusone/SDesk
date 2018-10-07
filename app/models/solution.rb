class Solution < ApplicationRecord
  validates :title, presence: true, uniqueness: {case_sensitive: false}
  validates_associated :solution_folder

  belongs_to :solution_folder
  has_many :file_attachments, as: :resource, dependent: :destroy

  accepts_nested_attributes_for :file_attachments, reject_if: :all_blank, allow_destroy: true, update_only: true

  default_scope {order :title}
end
