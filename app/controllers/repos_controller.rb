class ReposController < ApplicationController
  def index
    @repos = current_user.repos.order(active: :desc, full_github_name: :asc)
  end

  def sync
    #RepoSyncJob.perform_later(current_user)
    run Repo::Sync, params: { user: current_user }
    redirect_to repos_path
  end

  def activate
    run Repo::Activate, params: params.merge(user: current_user) do
      return redirect_to repos_path, notice: 'Activation initiated.'
    end

    redirect_to repos_path, alert: "Couldn't activate your repo."
  end

  def deactivate
    run Repo::Deactivate, params: params.merge(user: current_user) do
      return redirect_to repos_path, notice: 'Deactivation initiated.'
    end

    redirect_to repos_path, alert: "Couldn't deactivate your repo."
  end
end
