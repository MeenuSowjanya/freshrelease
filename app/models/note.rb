# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :user
  belongs_to :ticket
  has_many_attached :images
end
