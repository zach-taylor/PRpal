class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate

  helper_method :current_user, :signed_in?

  private

  def authenticate
    redirect_to root_path unless signed_in?
  end

  def signed_in?
    current_user.present? && current_user.token.present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
