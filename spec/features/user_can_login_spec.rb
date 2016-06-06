require 'rails_helper'

RSpec.feature "User logs in" do
  scenario "sees links index page" do
    user = create(:user, password: "password")
    visit '/'
    click_on "Log in"

    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_on "Log in"

    expect(current_path).to eq "/links"
    expect(page).to have_content "You have sucessfully logged in!"
    expect(page).to have_content "All the links for #{user.email}"
  end
end
