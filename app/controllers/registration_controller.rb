class RegistrationController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    @user = User.new
  end

  def create
    user = User.new(params.permit(:email_address, :password))
    if user.save
      start_new_session_for user
      redirect_to root_path
    else
      redirect_to new_registration_path, alert: "Try another email address or password."
    end
  end
end
