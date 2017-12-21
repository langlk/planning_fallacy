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

  it "does not allow user back to login page after logging in" do
    visit '/signin'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button "Sign in"
    visit '/signin'
    expect(page).to have_no_content('Sign In')
  end

  it "does not allow user back to signup page after logging in" do
    visit '/signin'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button "Sign in"
    visit '/signup'
    expect(page).to have_no_content('Have an account? Sign In')
  end
end
