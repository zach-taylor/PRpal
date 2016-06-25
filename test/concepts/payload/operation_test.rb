require 'test_helper'

class PayloadOperationTest < ActiveSupport::TestCase
  describe 'Create' do
    let (:repo) { Repo::Create.(full_github_name: 'PRpal/test-repo', github_id: 1).model }

    it 'invalid if repo does not exist' do
      res, op = Payload::Create.run(
        action: 'created',
        issue: { number: 1 },
        repository: { full_name: 'PRpal/test-repo2' }
      )

      res.must_equal false
    end

    it 'invalid if repo is not active' do
      res, op = Payload::Create.run(
        action: 'created',
        issue: { number: 1 },
        repository: { full_name: repo.full_github_name }
      )

      res.must_equal false
    end

    it 'updates successful status' do
      Webhook::Create.any_instance.stubs(:process).returns(true)
      Repo::Activate.(id: repo.id)

      stub_request_issue_comments_1
      stub_request_pull_request
      stub_request_status

      res, op = Payload::Create.run(
        action: 'created',
        issue: { number: 1 },
        repository: { full_name: repo.full_github_name }
      )

      res.must_equal true
    end

    it 'updates failure status' do
      Webhook::Create.any_instance.stubs(:process).returns(true)
      Repo::Activate.(id: repo.id)

      stub_request_issue_comments
      stub_request_pull_request
      stub_request_status(state: 'failure')

      res, op = Payload::Create.run(
        action: 'created',
        issue: { number: 1 },
        repository: { full_name: repo.full_github_name }
      )

      res.must_equal true
    end
  end
end