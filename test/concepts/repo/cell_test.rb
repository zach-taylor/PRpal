require 'test_helper'

class RepoCellTest < Cell::TestCase
  controller ReposController

  describe Repo::Cell::Show do
    let (:repo) { Repo::Create.(full_github_name: 'PRpal/test-repo', github_id: 1).model }

    it 'display show' do
      html = cell(Repo::Cell::Show, repo).()

      html.must_have_content repo.full_github_name
      html.must_have_link 'Activate'
    end

    it 'displays show for active repo' do
      Webhook::Create.any_instance.stubs(:process).returns(true)
      _res, op = Repo::Activate.run(id: repo.id)
      html = cell(Repo::Cell::Show, op.model).()

      html.must_have_content repo.full_github_name
      html.must_have_link 'Deactivate'
    end
  end

  describe Repo::Cell::Index do
    let (:repo1) { Repo::Create.(full_github_name: 'PRpal/test-repo', github_id: 1).model }
    let (:repo2) { Repo::Create.(full_github_name: 'PRpal/test-repo2', github_id: 2).model }

    it 'displays index' do
      html = cell(Repo::Cell::Index, [repo1, repo2]).()

      html.must_have_link 'PRpal/test-repo'
      html.must_have_link 'Activate'
      html.must_have_link 'PRpal/test-repo2'
    end
  end
end