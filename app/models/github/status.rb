# frozen_string_literal: true
module Github
  class Status
    CONTEXT = 'peer_review'.freeze

    attr_reader :repo_full_name, :sha, :status

    def initialize(params)
      @repo_full_name = params[:repo_full_name]
      @sha = params[:sha]
      @status = params[:status]
    end

    def save
      client.create_status(repo_full_name, sha, status, context: CONTEXT)
    end

    def client
      @client ||= Octokit::Client.new(
        login: Rails.application.secrets.github_login,
        password: Rails.application.secrets.github_password)
    end
  end
end
