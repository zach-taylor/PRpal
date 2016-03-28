class Payload
  class Create < Trailblazer::Operation
    def process(params)
      @params = params
      return invalid! if repo.nil?
      update_status unless @params['action'] == 'closed'
    end

    private

    def update_status
      status = success? ? 'success' : 'failure'
      client.create_status(repo_full_name, sha, status, context: 'peer-review/prpal')
    end

    def success?
      comments.each do |comment|
        return true if comment.body.start_with?(':+1:') && comment.user.login == assignee_login
      end
      false
    end

    def comments
      @comments ||= client.issue_comments(repo_full_name, pr_number)
    end

    def pr_number
      @params['number'] || @params['issue']['number']
    end

    def repo_full_name
      @params['repository']['full_name']
    end

    def pull_request
      @pull_request ||= client.pull_request(repo_full_name, pr_number)
    end

    def issue
      @issue ||= client.issue(repo_full_name, pr_number)
    end

    def assignee_login
      issue.assignee&.login
    end

    def sha
      pull_request.head.sha
    end

    def client
      @client ||= Octokit::Client.new(access_token: UserToken.new(repo).token, auto_paginate: true)
    end

    def repo
      Repo.find_by(full_github_name: repo_full_name)
    end
  end
end
