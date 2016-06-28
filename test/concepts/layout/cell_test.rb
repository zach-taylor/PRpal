require 'test_helper'

class LayoutCellTest < Cell::TestCase
  controller ApplicationController

  describe Layout::Cell::Nav do
    let (:user) { User.new(name: 'Zach Taylor') }

    it 'display a navbar' do
      html = cell(Layout::Cell::Nav, user).call

      html.must_have_link 'Repos'
      html.must_have_content 'Zach Taylor'
    end
  end

  describe Layout::Cell::Flash do
    it 'displays no flash message' do
      html = cell(Layout::Cell::Flash, {}).call

      html.wont_have_selector '.alert'
    end

    it 'displays a flash message' do
      html = cell(Layout::Cell::Flash, notice: 'Sync started!').call

      html.must_have_selector '.alert.alert-notice', text: 'Sync started!'
    end

    it 'displays two flash messages' do
      html = cell(Layout::Cell::Flash, notice: 'Sync started!', alert: 'Sad!').call

      html.must_have_selector '.alert.alert-notice', text: 'Sync started!'
      html.must_have_selector '.alert.alert-alert', text: 'Sad!'
    end
  end
end
