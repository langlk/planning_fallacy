require "rails_helper"

describe "the sessions management path" do
  let!(:user) { FactoryBot.create(:user) }

  it "allows a user to log in" do
    visit '/signin'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button "Sign in"
    expect(page).to have_content("Welcome back, #{user.name}!")
  end

  it "displays error if user cannot be logged in" do
    visit '/signin'
    click_button 'Sign in'
    expect(page).to have_content("Incorrect email or password.")
  end

  it "allows user to log out" do
    visit '/signin'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button "Sign in"
    click_link 'Sign out'
    expect(page).to have_content 'Sign In'
  end
end
