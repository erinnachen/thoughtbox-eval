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

    context "passwords do not match" do
      scenario "sees form again" do
        visit '/'
        click_on "Sign up"

        fill_in "Email", with: "newuser@example.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "notthepassword"
        click_on "Create account"

        expect(page).to have_content "Invalid account details"
      end
    end
  end
end
