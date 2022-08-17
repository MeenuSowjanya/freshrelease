# frozen_string_literal: true

class NoteCdActvity < ApplicationRecord
  belongs_to :ticket
  belongs_to :note
  belongs_to :activity
end
