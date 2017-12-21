class AuthRefreshAccess
  prepend SimpleCommand

  def initialize(account)
    @auth_client = CreateAuthClient.call.result
    @auth_client.access_token = account.access_token
    @auth_client.id_token = account.id_token
    @auth_client.expires_in = account.expires_in
    @auth_client.refresh_token = account.refresh_token
  end

  def call
    @auth_client.refresh!
    return @auth_client
  rescue Signet::AuthorizationError => exception
    errors.add(:authorization, 'could not authorize')
    return nil
  rescue ArgumentError => exception
    errors.add(:arguments, 'argument missing')
    return nil
  end
end
