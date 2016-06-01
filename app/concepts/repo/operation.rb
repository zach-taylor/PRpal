class Repo
  class Activate < Trailblazer::Operation
    include Model
    model Repo, :update

    contract do
      property :active
    end

    def process(params)
      validate(active: true) { |f| f.save }

      Webhook::Create.(repo: model, user: params[:user])
    end
  end

  class Deactivate < Trailblazer::Operation
    include Model
    model Repo, :update

    contract do
      property :active
    end

    def process(params)
      validate(active: false) { |f| f.save }

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
