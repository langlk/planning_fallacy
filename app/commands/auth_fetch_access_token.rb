class AuthFetchAccessToken
  prepend SimpleCommand

  def initialize(auth_code)
    @auth_client = CreateAuthClient.call.result
    @auth_client.code = auth_code
    @auth_client.redirect_uri = 'http://localhost:3000/oauth_callback'
  end

  def call
    if @auth_client.code
      @auth_client.fetch_access_token!
      return @auth_client
    else
      errors.add(:authentication, "not confirmed by user")
      nil
    end
  rescue Signet::AuthorizationError => exception
    errors.add(:authentication, "invalid code")
    nil
  end
end
