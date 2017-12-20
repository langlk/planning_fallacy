class AuthFetchAccessToken
  prepend SimpleCommand

  def initialize(auth_code)
    @auth_client = CreateAuthClient.call.result
    @auth_client.code = auth_code
    @auth_client.redirect_uri = 'http://localhost:3000/oauth_callback'
  end

  def call
    @auth_client.fetch_access_token!
    return @auth_client
  end
end
