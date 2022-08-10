# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in
  def new
    render 'users/new'
  end

  def index
    user = User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      session[:current_user_id] = user.id
      redirect_to tickets_path
    else
      flash[:error] = user.errors.full_messages.first
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :role, :password_confirmation)
  end
end
