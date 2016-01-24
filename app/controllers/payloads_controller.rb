class PayloadsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    PayloadJob.perform_later(params.to_h)
    head :ok
  end
end