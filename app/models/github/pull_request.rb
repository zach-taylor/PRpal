module Github
  class PullRequest
    def initialize(payload)
      @payload = payload
    end

    def reviewed?
      comments.each do |comment|
        return true if comment.body.start_with?(':+1:') && comment.user.login == assignee_login
      end
      false
    end

    def comments
      @comments ||= client.issue_comments(repo_full_name, pr_number)
    end

    def pr_number
      @payload[:number]
    end

    def repo_full_name
      @payload[:repository][:full_name]
    end

    def pull_request
      @pull_request ||= client.pull_request(repo_full_name, pr_number)
    end

    def issue
      @issue ||= client.issue(repo_full_name, pr_number)
    end

    def assignee_login
      issue.assignee.try(:login)
    end

    def sha
      pull_request.head.sha
    end

    def client
      @client ||= Octokit::Client.new(
        login: Rails.application.secrets.github_login,
        password: Rails.application.secrets.github_password)
    end
  end
end