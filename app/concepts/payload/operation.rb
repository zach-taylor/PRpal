class Payload
  class Create < Trailblazer::Operation
    # contract do
    #   property :number
    #   property :action
    #   property :issue do
    #     property :number
    #   end
    #   property :repository do
    #     property :full_name
    #   end
    # end

    def process(params)
      @params = params
      return invalid! if repo.nil?
      update_status unless @params[:action] == 'closed'
    end

    private

    def update_status
      status = success? ? 'success' : 'failure'
      log_status(status)
      client.create_status(repo_full_name, sha, status, context: 'peer-review/prpal')
    end

    def log_status(status)
      Rails.logger.info(
        "Status: #{status}",
        repo: repo_full_name, sha: sha, status: status,
        pr_number: pr_number, assignee: assignee_login
      )
    end

    def success?
      comments.each do |comment|
        Rails.logger.debug("comment_body=#{comment.body} user_login=#{comment.user.login}")
        return true if start_with_plus_1?(comment.body) && comment.user.login == assignee_login
      end
      false
    end

    def start_with_plus_1?(comment)
      comment.start_with?('👍') || comment.start_with?(':+1:')
    end

    def comments
      @comments ||= client.issue_comments(repo_full_name, pr_number)
    end

    def pr_number
      @params[:number] || @params[:issue][:number]
    end

    def repo_full_name
      @params[:repository][:full_name]
    end

    def pull_request
      @pull_request ||= client.pull_request(repo_full_name, pr_number)
    end

    def assignee_login
      pull_request.assignee&.login
    end

    def author_login
      pull_request.user&.login
    end

    def sha
      pull_request.head.sha
    end

    def client
      @client ||= Octokit::Client.new(access_token: UserToken.new(repo).token, auto_paginate: true)
    end

    def repo
      Repo.active.find_by(full_github_name: repo_full_name)
    end
  end
end
