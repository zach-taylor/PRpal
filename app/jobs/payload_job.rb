class PayloadJob < ApplicationJob
  def perform(args)
    Payload::Create.run(args)
  end
end
