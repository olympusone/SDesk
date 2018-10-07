class FileAttachment < ApplicationRecord
  has_one_attached :file

  validates_presence_of :file

  belongs_to :resource, polymorphic: true
end
