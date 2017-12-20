class UpdateAuthClient
  prepend SimpleCommand

  def initialize
    @auth_client = CreateAuthClient.call.result
  end

  def call
    @auth_client.update!(
      :scope => 'https://www.googleapis.com/auth/calendar.readonly',
      :redirect_uri => 'http://localhost:3000/oauth_callback',
      :additional_parameters => {
        "access_type" => "offline",         # offline access
        "include_granted_scopes" => "true"  # incremental auth
      }
    )
    return @auth_client
  end
end
