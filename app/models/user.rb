class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :avatar

  # Include default devise modules. Others available are: :validatable, :rememberable
  devise :database_authenticatable, :registerable, :recoverable, :trackable, :lockable,
         :timeoutable, :confirmable

  after_initialize :defaults
  before_save :check_user_status

  attr_accessor :confirmed, :locked, :skip_user_callbacks

  validates_presence_of :password, on: :create
  validates_confirmation_of :password, if: lambda{self.password.present?}
  validates_uniqueness_of :email, case_sensitive: false

  belongs_to :user, polymorphic: true

  def role?(role)
    _role = role.to_s.classify

    _role == self.user_type && _role.in?(%w[Agent Requester])
  end

  # return url for user avatar, else default image
  def avatar_path
    self.avatar.attached? ? self.avatar : 'avatar.png'
  end

  private

  def check_user_status
    self.skip_confirmation! if !self.confirmed.to_s.to_i.zero? && !self.confirmed?


    if !self.locked.to_s.to_i.zero? && !self.access_locked?
      self.locked_at = Time.now.to_s(:db)
    elsif self.access_locked?
    #   FIXME
    #   self.locked_at = nil
    #   self.failed_attempts = 0 if respond_to?(:failed_attempts=)
    #   self.unlock_token = nil  if respond_to?(:unlock_token=)
    end
  end

  def defaults
    self.confirmed ||= self.confirmed?
    self.locked ||= self.access_locked?
  end
end
