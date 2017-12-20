class CreateAuthClient
  prepend SimpleCommand

  def initialize
  end

  def call
    client_secrets = Google::APIClient::ClientSecrets.load
    auth_client = client_secrets.to_authorization
    return auth_client
  end
end
