require 'test_helper'

class UserOperationTest < ActiveSupport::TestCase
  describe 'FindOrCreate' do
    it 'creates new user' do
      stub_request_user

      _res, op = User::FindOrCreate.run(
        user: {
          uid: 1,
          info: { nickname: 'zach-taylor', email: 'zach@example.com', name: 'Zach Taylor' },
          credentials: { token: 'testtoken' }
        }
      )

      user = op.model

      user.persisted?.must_equal true

      user.email.must_equal 'zach@example.com'
      user.name.must_equal 'Zach Taylor'
      user.token.must_equal 'testtoken'
      user.token_scopes.must_equal ['repo', 'user:email']
      user.github_uid.must_equal 1
      user.github_username.must_equal 'zach-taylor'
    end
  end
end
