# require 'test_helper'
#
# class WebhookTest < ActiveSupport::TestCase
#   include Rack::Test::Methods
#
#   def app
#     Rails.application
#   end
#
#   it do
#     repo = Repo::Create.call(full_github_name: 'PRpal/test-repo', github_id: 1).model
#
#     the_payload = JSON.parse(file_fixture('webhook_create.json').read).to_json
#     signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), Rails.application.secrets.github_webhook_secret, the_payload)
#
#
#     post '/payloads/github', the_payload, { 'X-Hub-Signature' => signature }
#     last_response.ok?.must_equal true
#   end
# end
