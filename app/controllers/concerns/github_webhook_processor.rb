module GithubWebhookProcessor
  extend ActiveSupport::Concern

  included do
    before_action :verify_signature, only: :create
  end

  class SignatureError < StandardError; end
  class UnspecifiedWebhookSecretError < StandardError; end

  def create
    handle(json_body)
    head :ok
    # raise NoMethodError.new("GithubWebhooksController##{event} not implemented")
  end

  def ping(payload)
    logger.info(
      '[GithubWebhook::Processor] Hook ping received',
      hook_id: payload[:hook_id], zen: payload[:zen]
    )
  end

  private

  def verify_signature
    fail UnspecifiedWebhookSecretError unless respond_to?(:webhook_secret)
    secret = webhook_secret(json_body)

    signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), secret, request_body)
    fail SignatureError, "Signatures didn't match!" unless Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'])
  end

  def request_body
    @request_body ||=
      request.body.rewind
    request.body.read
  end

  def json_body
    @json_body ||= ActiveSupport::HashWithIndifferentAccess.new(JSON.load(request_body))
  end

  def signature_header
    @signature_header ||= request.headers['X-Hub-Signature']
  end

  def event
    @event ||= request.headers['X-GitHub-Event'].to_sym
  end
end
