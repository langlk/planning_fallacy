require "rails_helper"

describe "the user sign-up path" do
  it "allows a user to register with email, name, and password" do
    visit '/signup'
    fill_in 'user_name', with: "New User"
    fill_in 'user_email', with: "user@new.com"
    fill_in 'user_password', with: 'test1234'
    fill_in 'user_password_confirmation', with: 'test1234'
    click_button 'Sign up'
    expect(page).to have_content("Welcome, New User!")
  end

  it "displays errors if user cannot be registered" do
    visit '/signup'
    click_button 'Sign up'
    expect(page).to have_content('Something went wrong')
  end
end
