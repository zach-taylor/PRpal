class RepoSyncJob < ApplicationJob
  def perform(args)
    Repo::Sync.(args)
  end
end
