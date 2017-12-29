class CreateAuthClient
  prepend SimpleCommand

  def initialize
  end

  def call
    client_secrets = Google::APIClient::ClientSecrets.new(JSON.parse(ENV['GOOGLE_CLIENT_SECRETS']))
    auth_client = client_secrets.to_authorization
    return auth_client
  end
end
