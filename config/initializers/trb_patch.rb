module Cell
  module Testing
    private

    def controller_for(controller_class)
      # TODO: test without controller.
      return unless controller_class

      controller_class.new.tap do |ctl|
        ctl.request = ::ActionController::TestRequest.create
        ctl.instance_variable_set :@routes, ::Rails.application.routes.url_helpers
      end
    end
  end
end
