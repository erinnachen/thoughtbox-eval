# If I click "Sign Up", I should be taken to a user form where I can enter an email address, a password, and a password confirmation.
#
# I cannot sign up with an email address that has already been used.
# Password and confirmation must match.
# Upon submitting this information, I should be logged in via a cookie and redirected to the "Links Index" page.
require 'rails_helper'

RSpec.feature "User signs up for account" do
  scenario "on the links index page" do
    visit '/'
    click_on "Sign up"

    expect(current_path).to eq "/users/new"
    fill_in "Email", with: "funthoughts@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Create account"

    expect(current_path).to eq "/links"
    expect(page).to have_content "You have signed up!"
    expect(page).to have_content "All the links for funthoughts@example.com"
  end

  describe "invalid signup" do
    context "not a unique email" do
      scenario "sees form again" do
        create(:user, email: "oldemail@example.com")
        visit '/'
        click_on "Sign up"

        fill_in "Email", with: "oldemail@example.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        click_on "Create account"

        expect(page).to have_content "Invalid account details"
      end
    end
  end
end
