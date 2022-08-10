# frozen_string_literal: true

class Agent < ApplicationRecord
  belongs_to :user
  belongs_to :organisation
end
