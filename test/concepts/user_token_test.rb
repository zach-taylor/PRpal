require 'test_helper'

class UserTokenTest < ActiveSupport::TestCase
  describe '#token' do
    let (:user) do
      stub_request_user

      User::FindOrCreate.(
        user: {
          uid: 1,
          info: { nickname: 'zach-taylor', email: 'zach@example.com', name: 'Zach Taylor'},
          credentials: { token: 'testtoken' }
        }
      ).model
    end

    let (:repo) { Repo::Create.(full_github_name: 'PRpal/test-repo', github_id: 1).model }

    it 'returns the token for a user' do
      Membership.create(user: user, repo: repo)
      token = UserToken.new(repo)

      token.token.must_equal 'testtoken'
    end

    it 'returns the default token if no user' do
      token = UserToken.new(repo)

      token.token.must_equal 'defaulttoken'
    end
  end
end