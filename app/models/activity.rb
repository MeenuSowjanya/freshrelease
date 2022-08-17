# frozen_string_literal: true

class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :action
  belongs_to :activity_model
  belongs_to :ticket
end
