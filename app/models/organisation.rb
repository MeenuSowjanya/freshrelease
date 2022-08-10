# frozen_string_literal: true

class Organisation < ApplicationRecord
  has_many :agents
end
