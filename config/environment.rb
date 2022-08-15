# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
config.action_mailer.default_url_options = { host: 'https://zupp-ticket-app-test.herokuapp.com/' }
ActionMailer::Base.smtp_settings = {
    user_name: 'zuppticketingapp@gmail.com',
    password: 'gxkibmtbxumosznt',
    address: 'smtp.gmail.com',
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true
  }
