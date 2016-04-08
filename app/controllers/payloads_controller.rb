class PayloadsController < ApplicationController
  include GithubWebhookProcessor
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate

  def handle(payload)
    PayloadJob.perform_later(payload)
  end

  def webhook_secret(_payload)
    Rails.application.secrets.github_webhook_secret
  end
end
