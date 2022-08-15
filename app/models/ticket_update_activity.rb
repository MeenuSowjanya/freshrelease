class TicketUpdateActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :ticket
end
