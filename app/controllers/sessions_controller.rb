class SessionsController < ApplicationController
  skip_before_action :authenticate, only: :create

  def create
    run User::FindOrCreate, params: { user: request.env['omniauth.auth'] } do |op|
      session[:id] = op.model.id
      return redirect_to repos_path
    end

    redirect_to root_path
  end
end
