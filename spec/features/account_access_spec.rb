require "rails_helper"

describe 'access with and without an account' do
  let!(:user) { FactoryBot.create(:user) }

  it "does not allow user to visit other site pages before linking account" do
    visit '/signin'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button "Sign in"
    visit '/'
    expect(page).to have_content('Add Your Google Calendar')
  end

  it "does allow user to visit other site pages after linking account" do
    FactoryBot.create(:account, user: user)
    visit '/signin'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button "Sign in"
    visit '/'
    expect(page).to have_content('Check In')
  end

  it "does not allow user back to add account page when they have an account" do
    FactoryBot.create(:account, user: user)
    visit '/signin'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button "Sign in"
    visit '/add_account'
    expect(page).to have_no_content('Add Your Google Calendar')
  end
end
