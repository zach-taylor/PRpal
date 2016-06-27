class Repo
  module Cell
    class Index < Trailblazer::Cell
      include ActionView::Helpers::TranslationHelper
      include ::Cell::Translation
    end
  end
end
