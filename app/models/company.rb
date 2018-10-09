class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :domain, presence: true, uniqueness: {case_sensitive: false}

  has_many :requesters, dependent: :restrict_with_error
end
