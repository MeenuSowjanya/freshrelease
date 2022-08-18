# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
  ActionMailer::Base.smtp_settings = {
    user_name: 'zuppticketingapp@gmail.com',
    password: 'dzbxfwnabptqozqs',
    domain: 'zupp-ticket-app-test.herokuapp.com',
    address: 'smtp.gmail.com',
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true
  }
