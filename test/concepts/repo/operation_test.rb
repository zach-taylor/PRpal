require 'test_helper'

class RepoOperationTest < ActiveSupport::TestCase
  describe 'Create' do
    it 'persists valid' do
      _res, op = Repo::Create.run(full_github_name: 'zach-taylor/test-repo', github_id: 19549738)

      repo = op.model

      repo.persisted?.must_equal true
      repo.full_github_name.must_equal 'zach-taylor/test-repo'
      repo.github_id.must_equal 19549738
    end

    it 'does not persist with missing fulL_github_name' do
      res, op = Repo::Create.run(github_id: 19549738)

      res.must_equal false

      op.errors.messages.must_equal full_github_name: ["can't be blank"]
    end

    it 'does not persist with missing github_id' do
      res, op = Repo::Create.run(full_github_name: 'zach-taylor/test-repo')

      res.must_equal false

      op.errors.messages.must_equal github_id: ["can't be blank"]
    end
  end

  describe 'Update' do
    it 'persists valid with github_id changed' do
      _res, op = Repo::Create.run(full_github_name: 'zach-taylor/test-repo', github_id: 19549738)

      repo_id = op.model.id

      res, op2 = Repo::Update.run(full_github_name: 'zach-taylor/test-repo', github_id: 1954)

      repo = op2.model

      res.must_equal true

      repo.id.must_equal repo_id
      repo.full_github_name.must_equal 'zach-taylor/test-repo'
      repo.github_id.must_equal 1954
    end

    it 'persists valid with full_github_name changed' do
      _res, op = Repo::Create.run(full_github_name: 'zach-taylor/test-repo', github_id: 19549738)

      repo_id = op.model.id

      res, op2 = Repo::Update.run(full_github_name: 'zach-taylor/test-repo2', github_id: 19549738)

      repo = op2.model

      res.must_equal true

      repo.id.must_equal repo_id
      repo.full_github_name.must_equal 'zach-taylor/test-repo2'
      repo.github_id.must_equal 19549738
    end
  end

  describe 'Activate' do
  end

  describe 'Deactivate' do
  end

  describe 'Sync' do
  end
end
