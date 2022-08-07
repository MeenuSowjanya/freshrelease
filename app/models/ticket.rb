class Ticket < ApplicationRecord
    belongs_to :user
    belongs_to :priority
    belongs_to :status
    has_many_attached :screenshots
    has_many :notes
end
