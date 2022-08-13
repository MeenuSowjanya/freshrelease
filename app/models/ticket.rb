# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :priority
  belongs_to :status
  has_many_attached :screenshots
  has_many :notes
  VALID_TEXT_REGEX = /\A[A-Za-z]+(?:\s[A-Za-z]+)*\z/.freeze
  validates :subject, presence: true, length: { minimum: 3, maximum: 100 }, format: { with: VALID_TEXT_REGEX }
  validates :status_id, presence: true
  validates :priority_id, presence: true
  validates :agent, presence: true
  validates :description, presence: true, length: { minimum: 3, maximum: 255 }, format: { with: VALID_TEXT_REGEX }
end
