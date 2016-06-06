require 'rails_helper'

RSpec.feature "Logged in user can submit links" do
  include SpecHelpers

  context "valid link submitted" do
    scenario "sees link on index page" do
      title = "Capybara fun"
      url = "http://giphy.com/gifs/party-pool-capybara-ddUrtZA5JZD6E"
      user = login_user
      fill_in "Title", with: title
      fill_in "Url", with: url
      click_on "Submit new link"

      expect(current_path).to eq "/links"
      expect(page).to have_content "Added new link: #{title}"
      within(".links") do
        expect(page).to have_link(title, href: url)
      end
    end
  end

  context "invalid link submitted" do
    scenario "does not link on index page" do
      title = "Capybara fun"
      url = "not valid url"
      user = login_user
      fill_in "Title", with: title
      fill_in "Url", with: url
      click_on "Submit new link"

      expect(current_path).to eq "/links"
      expect(page).to_not have_content "Added new link: #{title}"
      expect(page).to have_content "Not valid link submission"
      within(".links") do
        expect(page).to_not have_link(title, href: url)
      end
    end
  end
end
