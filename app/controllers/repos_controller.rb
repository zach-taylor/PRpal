class ReposController < ApplicationController
  def index
    run Repo::Index, params: { user: current_user } do |op|
      render html: cell(Repo::Cell::Index, op.model), layout: true
    end
  end

  def sync
    #RepoSyncJob.perform_later(current_user)
    run Repo::Sync, params: { user: current_user }
    redirect_to repos_path
  end

  def activate
    run Repo::Activate, params: params.merge(user: current_user) do
      return redirect_to repos_path, notice: t('.success')
    end

    redirect_to repos_path, alert: t('.failure')
  end

  def deactivate
    run Repo::Deactivate, params: params.merge(user: current_user) do
      return redirect_to repos_path, notice: t('.success')
    end

    redirect_to repos_path, alert: t('.failure')
  end
end
