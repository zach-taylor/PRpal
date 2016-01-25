class PayloadsController < ApplicationController
  include GithubWebhookProcessor
  skip_before_action :verify_authenticity_token

  def handle(payload)
    PayloadJob.perform_later(payload)
  end

  def webhook_secret(payload)
    Rails.application.secrets.github_webhook_secret
  end

  # private
  #
  # def payload_params
  #   params.require(:payload).permit(
  #     :action, :number,
  #     pull_request: [:id, :number, :body, user: [:login]],
  #     issue: [:number],
  #     repository: [:full_name]
  #   )
  # end
end