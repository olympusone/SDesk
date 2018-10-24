class Solution < ApplicationRecord
  before_validation :strip_tags

  validates :title, presence: true, uniqueness: {case_sensitive: false}
  validates_associated :solution_folder

  searchable do
    text :title, :content, :tags
  end

  belongs_to :solution_folder
  has_many :file_attachments, as: :resource, dependent: :destroy

  accepts_nested_attributes_for :file_attachments, reject_if: :all_blank, allow_destroy: true, update_only: true

  default_scope {order :title}

  private
  def strip_tags
    self.tags.remove!(/\"|\\/)
  end
end
