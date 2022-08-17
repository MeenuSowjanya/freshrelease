# frozen_string_literal: true

class NoteUpdateActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :ticket
  belongs_to :note
end
