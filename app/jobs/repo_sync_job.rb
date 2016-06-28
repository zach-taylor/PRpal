class RepoSyncJob < ApplicationJob
  def perform(args)
    Repo::Sync.call(args)
  end
end
