module SessionHelper
  def sign_up
    OmniAuth.config.add_mock(
      :github,
      info: {
        name: 'Zach Taylor',
        nickname: 'zach-taylor',
        email: 'ztaylor234@gmail.com'
      },
      credentials: {
        token: 'testtoken'
      }
    )

    stub_request_user

    visit root_path
    click_on I18n.t(:login)
  end

  def sign_out
    click_on I18n.t(:logout)
  end

  def sign_in
    sign_up

    sign_out

    click_on I18n.t(:login)
  end
end
