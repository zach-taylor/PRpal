module Webhook
  class Create < Trailblazer::Operation
    def process(params)
      @repo = params[:repo]
      @token = params[:user].token
      create_webhook
    end

    private

    def github
      @github ||= Octokit::Client.new(access_token: @token, auto_paginate: true)
    end

    def create_webhook
      hook = github.create_hook(
        @repo.full_github_name,
        'web',
        { url: builds_url, secret: Rails.application.secrets.github_webhook_secret },
        { events: ['pull_request', 'issue_comment'], active: true }
      )
      @repo.update(hook_id: hook.id)
    rescue Octokit::UnprocessableEntity => error
      if error.message.include? 'Hook already exists'
        true
      else
        raise
      end
    end

    def builds_url
      Rails.application.secrets.webhook_url
    end
  end
end