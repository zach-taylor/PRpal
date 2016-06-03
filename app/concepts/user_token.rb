class UserToken
  attr_private_initialize :repo

  def token
    user.token
  end

  def user
    @user ||= user_with_token || user_with_default_token
  end

  private

  def user_with_default_token
    User.new(token: Rails.application.secrets.github_token)
  end

  def user_with_token
    repo.users.without_token.sample
  end
end
