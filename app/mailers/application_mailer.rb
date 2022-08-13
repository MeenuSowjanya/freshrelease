# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'zuppticketingapp.com'
  layout 'mailer'
end
