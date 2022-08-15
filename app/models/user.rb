# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :tickets  # Corresponding association with todos table
  has_many :notes
  has_many :canned_responses
  has_many :activities
  VALID_NAME_REGEX = /\A[^0-9`!@#$%\^&*+_=]+\z/.freeze
  VALID_EMAIL_REGEX = /\A(.+)@(.+)$\z/.freeze
  validates :first_name, presence: true, length: { minimum: 3, maximum: 25 }, format: { with: VALID_NAME_REGEX }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 25 }, format: { with: VALID_NAME_REGEX }
  validates :email, presence: true, length: { minimum: 10, maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6, maximum: 255 }, confirmation: true
  validates :password_confirmation, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def to_s
    "name => #{full_name}, email=> #{email}"
  end
end
