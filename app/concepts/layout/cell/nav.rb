module Layout
  module Cell
    class Nav < Trailblazer::Cell
      include ActionView::Helpers::TranslationHelper
      include ::Cell::Translation

      private

      def repos_link
        link_to Repo.model_name.human(count: :many), repos_path, class: 'active item'
      end
    end
  end
end
