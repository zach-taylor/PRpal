class PayloadJob < ApplicationJob
  def perform(args)
    Payload::Create.(args)
  end
end
