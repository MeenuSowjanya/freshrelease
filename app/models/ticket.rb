class Ticket < ApplicationRecord
  belongs_to :user
  validates :subject, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  validates :description, presence: true
end
