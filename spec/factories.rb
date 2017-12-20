FactoryBot.define do
  factory(:user) do
    name "Test User"
    email "test@test.com"
    password "test1234"
    password_confirmation "test1234"
  end

  factory(:account) do
    user
    access_token "mock_access_token"
    id_token "mock_id_token"
    refresh_token "mock_refresh_token"
    expires_in 3600
  end

  factory(:checkin) do
    account
    event_time Time.now
    event_id "mock_event_id"
  end
end
