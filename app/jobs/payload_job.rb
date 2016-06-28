class PayloadJob < ApplicationJob
  def perform(args)
    Payload::Create.call(args)
  end
end
