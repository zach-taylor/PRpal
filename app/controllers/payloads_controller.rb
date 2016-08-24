class PayloadsController < ApplicationController
  before_action :verify_signature, only: :create
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate

  class SignatureError < StandardError; end

  def create
    PayloadJob.perform_later(json_body.deep_symbolize_keys)
  end

  private

  def verify_signature
    signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), webhook_secret, request.raw_post)
    raise SignatureError, "Signatures didn't match!" unless Rack::Utils.secure_compare(signature, signature_header)
  end

  def webhook_secret
    Rails.application.secrets.github_webhook_secret
  end

  def signature_header
    @signature_header ||= request.headers['X-Hub-Signature']
  end

  def json_body
    @json_body ||= ActiveSupport::HashWithIndifferentAccess.new(JSON.load(request.raw_post))
  end
end
