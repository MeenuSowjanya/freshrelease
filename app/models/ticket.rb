# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :priority
  belongs_to :status
  has_many_attached :screenshots
  has_many :notes
  has_many :activities
  has_one :ticket_cd_activities
  has_many :ticket_update_activities
  VALID_TEXT_REGEX = /\A[A-Za-z]+(?:\s[A-Za-z]+)*\z/.freeze
  validates :subject, presence: true, length: { minimum: 3, maximum: 100 }
  validates :status_id, presence: true
  validates :priority_id, presence: true
  validates :agent, presence: true
  validates :description, presence: true, length: { minimum: 3, maximum: 255 }
end
