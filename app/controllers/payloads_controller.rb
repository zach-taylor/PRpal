class PayloadsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    run Payload::Create do |_op|
      head :created and return
    end
    head :bad_request
  end
end