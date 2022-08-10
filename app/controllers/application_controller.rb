# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :ensure_user_logged_in

  def ensure_user_logged_in
    redirect_to root_path unless current_user
  end

  # memoization
  def current_user
    return @current_user if @current_user

    current_user_id = session[:current_user_id]
    @current_user = User.find(current_user_id) if current_user_id
  end
end
