# frozen_string_literal: true

class ActivitiesController < ApplicationController
  def show
    current_user
    @user = User.find(current_user.id)
    @ticket = Ticket.find(params[:id])
    @activities = @ticket.activities
    @user_org = Organisation.all # Used for editing ticket properties
    @canned_responses = @user.canned_responses # To list canned responses for bot feature
  end
end
