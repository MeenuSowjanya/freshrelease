# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  skip_before_action :ensure_user_logged_in
  def new; end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      PasswordMailer.with(user: @user).reset.deliver_now
      flash[:error] = 'Reset password link has been sent'
    else
      flash[:error] = 'Your reset password attempt went wrong'
    end
    redirect_to new_sessions_path
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    flash[:error] = 'Something went wrong in resetting password. Please try again'
    redirect_to new_sessions_path
  end

  def update
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
    if @user.update(password_params)

      flash[:error] = 'Your password was updated successfully. Please signin'
      redirect_to new_sessions_path
    else

      flash[:error] = 'Something went wrong in resetting password. Please try again'
      render :edit

    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
