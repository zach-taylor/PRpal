class Repo
  class Index < Trailblazer::Operation
    def process(params)
      @model = params[:user].repos.order(active: :desc, full_github_name: :asc)
    end
  end

  class Activate < Trailblazer::Operation
    include Model
    model Repo, :update

    contract do
      property :active
    end

    def process(params)
      validate(active: true, &:save)

      Webhook::Create.call(repo: model, user: params[:user])
    end
  end

  class Deactivate < Trailblazer::Operation
    include Model
    model Repo, :update

    contract do
      property :active
    end

    def process(params)
      validate(active: false, &:save)

      Webhook::Destroy.call(repo: model, user: params[:user])
    end
  end

  class Sync < Trailblazer::Operation
    def process(params)
      user = params[:user]

      user.repos.clear
      repos = github(user.token).repos

      Repo.transaction do
        repos.each do |resource|
          op = Repo::Create.call(repo_attributes(resource.to_hash))
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
    builds -> (params) { Update if Repo.find_by_github(params) }

    include Model
    model Repo, :create

    contract do
      property :full_github_name
      property :github_id

      validates :full_github_name, presence: true
      validates :github_id, presence: true
    end

    def process(params)
      validate(params, &:save)
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
