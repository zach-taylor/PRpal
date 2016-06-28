require 'test_helper'

class SessionTest < Capybara::Rails::TestCase
  it 'signs up and logs out' do
    sign_up

    page.must_have_content 'Zach Taylor'
    page.must_have_link 'Repos'
    page.must_have_link I18n.t('repo.view.refresh')

    sign_out

    current_path.must_equal root_path
    page.must_have_link I18n.t(:login)
  end

  it 'signs up, logs out, logs back in' do
    sign_in
  end

  it 'redirects to root if not logged in' do
    visit repos_path

    current_path.must_equal root_path
    page.must_have_link I18n.t(:login)
  end
end
