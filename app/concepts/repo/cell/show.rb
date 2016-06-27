class Repo
  module Cell
    class Show < Trailblazer::Cell
      include ActionView::Helpers::TranslationHelper
      include ::Cell::Translation
      property :full_github_name
      property :github_id
      property :active

      private

      def github_link
        link_to full_github_name, "https://github.com/#{full_github_name}"
      end

      def active_link
        if active
          link_to t('.deactivate'), deactivate_repo_path(model), method: :put
        else
          link_to t('.activate'), activate_repo_path(model), method: :put
        end
      end
    end
  end
end
