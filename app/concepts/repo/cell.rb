class Repo
  class Cell < Cell::Concept
    property :full_github_name
    property :github_id
    property :active

    def show
      render
    end

    private

    def active_link
      if active
        link_to 'Deactivate', deactivate_repo_path(model), method: :put
      else
        link_to 'Activate', activate_repo_path(model), method: :put
      end
    end
  end
end