# frozen_string_literal: true

class ActivitiesController < ApplicationController
  def index
    @activities = Activity.all
    @ticket_update_activities = TicketUpdateActivity.all
  end
end
