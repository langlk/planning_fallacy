require "rails_helper"

describe 'the calendar path spec', vcr: true do
  let!(:account) { FactoryBot.create(:account,
    refresh_token: "correct_refresh_token",
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

  it "displays a user's calendar events" do
    visit '/calendar'
    expect(page).to have_content('Planning Fallacy Test Event')
  end
end
