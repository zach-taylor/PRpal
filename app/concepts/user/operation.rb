class User
  class FindOrCreate < Trailblazer::Operation
    def process(params)
      user = User.find_or_initialize_by(provider: 'github', github_uid: params[:user]['uid'])
      user.github_username = params[:user]['info']['nickname']
      user.email = params[:user]['info']['email']
      user.name = params[:user]['info']['name']
      user.token = params[:user]['credentials']['token']
      user.token_scopes = token_scopes(params[:user]['credentials']['token'])
      user.save
      @model = user
    end

    private

    def github(token)
      @github ||= Octokit::Client.new(access_token: token, auto_paginate: true)
    end

    def token_scopes(token)
      @token_scopes ||= github(token).scopes
    end
  end
end
