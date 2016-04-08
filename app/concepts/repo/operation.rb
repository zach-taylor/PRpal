class Repo
  class Activate < Trailblazer::Operation
    def process(params)
      model = Repo.find(params[:id])
      model.update(active: true)
      Webhook::Create.(repo: model, user: params[:user])
    end
  end

  class Deactivate < Trailblazer::Operation
    def process(params)
      model = Repo.find(params[:id])
      model.update(active: false)
      Webhook::Destroy.(repo: model, user: params[:user])
    end
  end

  class Sync < Trailblazer::Operation
    def process(params)
      user = params[:user]

      user.repos.clear
      repos = github(user.token).repos

      Repo.transaction do
        repos.each do |resource|
          attributes = repo_attributes(resource.to_hash)
          repo = Repo.find_or_create_with(attributes)
          user.memberships.create!(repo: repo)
        end
      end
    end

    private

    def github(token)
      @github ||= Octokit::Client.new(access_token: token, auto_paginate: true)
    end

    def repo_attributes(attributes)
      {
        github_id: attributes[:id],
        full_github_name: attributes[:full_name]
      }
    end
  end
end
