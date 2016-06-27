require 'test_helper'

class RepoTest < Capybara::Rails::TestCase
  it 'syncs repos' do
    stub_request_repos

    sign_up

    click_on I18n.t('repo.view.refresh')

    page.must_have_link 'PRpal/test-repo'
    page.must_have_link 'Activate'
    page.must_have_link 'PRpal/test-repo2'
  end

  it 'activates and deactivates repos' do
    stub_request_repos
    stub_request_webhook_create(callback_endpoint: 'http://prpal.dev:5000/payloads/github')
    stub_request_webhook_delete

    sign_up
    click_on I18n.t('repo.view.refresh')
    click_on I18n.t('repo.view.activate'), match: :first
    click_on I18n.t('repo.view.deactivate'), match: :first
  end
end