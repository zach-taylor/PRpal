require 'test_helper'

class RepoOperationTest < ActiveSupport::TestCase
  describe 'Create' do
    it 'persists valid' do
      _res, op = Repo::Create.run(full_github_name: 'PRpal/test-repo', github_id: 1)

      repo = op.model

      repo.persisted?.must_equal true
      repo.full_github_name.must_equal 'PRpal/test-repo'
      repo.github_id.must_equal 1
    end

    it 'does not persist with missing fulL_github_name' do
      res, op = Repo::Create.run(github_id: 1)

      res.must_equal false

      op.errors.messages.must_equal full_github_name: ["can't be blank"]
    end

    it 'does not persist with missing github_id' do
      res, op = Repo::Create.run(full_github_name: 'PRpal/test-repo')

      res.must_equal false

      op.errors.messages.must_equal github_id: ["can't be blank"]
    end
  end

  describe 'Update' do
    it 'persists valid with github_id changed' do
      _res, op = Repo::Create.run(full_github_name: 'PRpal/test-repo', github_id: 1)

      repo_id = op.model.id

      res, op2 = Repo::Update.run(full_github_name: 'PRpal/test-repo', github_id: 2)

      repo = op2.model

      res.must_equal true

      repo.id.must_equal repo_id
      repo.full_github_name.must_equal 'PRpal/test-repo'
      repo.github_id.must_equal 2
    end

    it 'persists valid with full_github_name changed' do
      _res, op = Repo::Create.run(full_github_name: 'PRpal/test-repo', github_id: 1)

      repo_id = op.model.id

      res, op2 = Repo::Update.run(full_github_name: 'PRpal/test-repo2', github_id: 1)

      repo = op2.model

      res.must_equal true

      repo.id.must_equal repo_id
      repo.full_github_name.must_equal 'PRpal/test-repo2'
      repo.github_id.must_equal 1
    end
  end

  describe 'Activate' do
    it 'activates' do
      Webhook::Create.any_instance.stubs(:process).returns(true)

      _res, op = Repo::Create.run(full_github_name: 'PRpal/test-repo', github_id: 1)
      id = op.model.id

      _res, op = Repo::Activate.run(id: id)

      op.model.active.must_equal true
    end
  end

  describe 'Deactivate' do
    it 'deactivates' do
      Webhook::Create.any_instance.stubs(:process).returns(true)

      _res, op = Repo::Create.run(full_github_name: 'PRpal/test-repo', github_id: 1)
      id = op.model.id

      _res, op = Repo::Activate.run(id: id)

      op.model.active.must_equal true

      Webhook::Destroy.any_instance.stubs(:process).returns(true)

      _res, op = Repo::Deactivate.run(id: id)

      op.model.active.must_equal false
    end
  end

  describe 'Sync' do
  end
end
