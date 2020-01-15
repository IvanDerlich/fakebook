module OmniauthHelper
  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      provider: 'Facebook',
      uid: '1234567',
      info: {
        email: 'joe@bloggs.com',
        name: 'Joe Bloggs',
        first_name: 'Joe',
        last_name: 'Bloggs'
      },
      credentials: {
        token: 'abcdefg12345', # OAuth 2.0 access_token, which you may wish to store
        expires_at: 1321747205, # when the access token expires (it always will)
        expires: true # this will always be true
      }
    })
  end
end