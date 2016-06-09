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
          op = Repo::Create.(repo_attributes(resource.to_hash))
          user.memberships.create!(repo: op.model)
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

  class Create < Trailblazer::Operation
    builds(lambda do |params|
      Update if Repo.find_by_github(params)
    end)

    include Model
    model Repo, :create

    contract do
      property :full_github_name
      property :github_id

      validates :full_github_name, presence: true
      validates :github_id, presence: true
    end

    def process(params)
      validate(params) do |f|
        f.save
      end
    end
  end

  class Update < Create
    action :update

    private

    def update_model(params)
      model_class.find_by_github(params)
    end
  end
end
