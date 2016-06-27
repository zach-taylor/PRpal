module GithubHelper
  def stub_request_user(token: 'testtoken')
    stub_request(:get, 'https://api.github.com/user')
      .with(
        headers: {
          'Accept': 'application/vnd.github.v3+json',
          'Authorization': "token #{token}",
          'Content-Type': 'application/json',
          'User-Agent': 'Octokit Ruby Gem 4.3.0',
        }
      ).to_return(
        status: 200,
        headers: { 'X-OAuth-Scopes': 'repo,user:email' },
        body: ''
      )
  end

  def stub_request_repos(token: 'testtoken')
    repos_url = 'https://api.github.com/user/repos'

    stub_request(:get, "#{repos_url}?per_page=100")
      .with(
        headers: {
          'Authorization': "token #{token}",
          'Accept': 'application/vnd.github.v3+json',
          'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type': 'application/json',
          'User-Agent': 'Octokit Ruby Gem 4.3.0'
        }
      )
      .to_return(
        status: 200,
        body: file_fixture('repos.json'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8'
        }
      )
  end

  def stub_request_issue_comments_1(repo_name: 'PRpal/test-repo')
    stub_request(:get, "https://api.github.com/repos/#{repo_name}/issues/1/comments?per_page=100")
      .with(
        headers: {
          'Accept': 'application/vnd.github.v3+json',
          'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type': 'application/json',
          'User-Agent': 'Octokit Ruby Gem 4.3.0'
        }
      ).to_return(
        status: 200,
        headers: { 'Content-Type': 'application/json; charset=utf-8' },
        body: file_fixture('issue_comments_+1.json')
      )
  end

  def stub_request_issue_comments(repo_name: 'PRpal/test-repo')
    stub_request(:get, "https://api.github.com/repos/#{repo_name}/issues/1/comments?per_page=100")
      .with(
        headers: {
          'Accept': 'application/vnd.github.v3+json',
          'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type': 'application/json',
          'User-Agent': 'Octokit Ruby Gem 4.3.0'
        }
      ).to_return(
      status: 200,
      headers: { 'Content-Type': 'application/json; charset=utf-8' },
      body: file_fixture('issue_comments.json')
    )
  end

  def stub_request_pull_request
    stub_request(:get, 'https://api.github.com/repos/PRpal/test-repo/pulls/1')
      .with(
        headers: {
          'Accept': 'application/vnd.github.v3+json',
          'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type': 'application/json',
          'User-Agent': 'Octokit Ruby Gem 4.3.0'
        }
      ).to_return(
        status: 200,
        headers: { 'Content-Type': 'application/json; charset=utf-8' },
        body: file_fixture('pull_request.json')
      )
  end

  def stub_request_status(state: 'success')
    stub_request(:post, 'https://api.github.com/repos/PRpal/test-repo/statuses/6dcb09b5b57875f334f61aebed695e2e4193db5e')
    .with(
      body: {
        context: 'peer-review/prpal',
        state: state
      }.to_json,
      headers: {
        'Accept': 'application/vnd.github.v3+json',
        'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Content-Type': 'application/json',
        'User-Agent': 'Octokit Ruby Gem 4.3.0'
      }
    ).to_return(status: 200, body: '')
  end

  def stub_request_webhook_create(full_repo_name: 'PRpal/test-repo', callback_endpoint:, token: 'testtoken')
    stub_request(:post, "https://api.github.com/repos/#{full_repo_name}/hooks")
    .with(
      body: {
        name: 'web',
        config: {
          url: callback_endpoint,
          secret: 'test',
          content_type: 'json'
        },
        events: ['pull_request', 'issue_comment'],
        active: true,
      }.to_json,
      headers: { 'Authorization': "token #{token}" }
    ).to_return(
      status: 200,
      headers: { 'Content-Type': 'application/json; charset=utf-8' },
      body: file_fixture('webhook_create.json')
    )
  end

  def stub_request_webhook_delete(repo_name: 'PRpal/test-repo', hook_id: 1, token: 'testtoken')
    stub_request(:delete, "https://api.github.com/repos/#{repo_name}/hooks/#{hook_id}")
      .with(headers: { 'Authorization': "token #{token}"})
      .to_return(status: 204)
  end
end