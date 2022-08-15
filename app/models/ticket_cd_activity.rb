# frozen_string_literal: true

class TicketCdActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :ticket
end
