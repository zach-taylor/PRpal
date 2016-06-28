require 'test_helper'

class WebhookOperationTest < ActiveSupport::TestCase
  describe 'Create' do
    let (:repo) { Repo::Create.call(full_github_name: 'PRpal/test-repo', github_id: 1).model }
    let (:user) { User.new(token: 'testtoken') }

    it 'creates a webhook' do
      stub_request_webhook_create(callback_endpoint: Rails.application.secrets.webhook_url)
      _res, op = Webhook::Create.run(repo: repo, user: user)

      op.model.hook_id.must_equal 1
    end

    it 'deletes a webhook' do
      stub_request_webhook_delete
      repo.hook_id = 1
      _res, _op = Webhook::Destroy.run(repo: repo, user: user)
    end
  end
end
