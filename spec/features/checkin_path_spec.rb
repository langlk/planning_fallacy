require "rails_helper"

describe "checking in to an event", vcr: true do
  let!(:account) { FactoryBot.create(:account,
    refresh_token: "1/k4jBqFsGg_XSLk2HqkwzaN-oCK03C0L_RhM3SQoMrXg",
    access_token: 'correct_access_token',
    expires_in: 3600,
    id_token: nil
  )}

  before do
    visit '/signin'
    fill_in 'email', with: account.user.email
    fill_in 'password', with: account.user.password
    click_button "Sign in"
  end

  it "allows a user to choose from recent and upcoming events" do
    visit '/checkin'
    expect(page).to have_content('Planning Fallacy Test Event')
  end

  it "allows a user to check in to an event" do
    visit '/checkin'
    click_button 'Check In'
    expect(Checkin.last.account).to eq(account)
  end
end
