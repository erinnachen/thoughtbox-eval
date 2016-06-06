require 'rails_helper'

RSpec.feature "Logged in user can change status links" do
  include SpecHelpers

  context "link has unread status" do
    scenario "sees link become read" do
      title = "Capybara fun"
      url = "http://giphy.com/gifs/party-pool-capybara-ddUrtZA5JZD6E"
      user = login_user
      link = user.links.create(title: title, url: url)

      visit "/links"
      expect(page).to_not have_selector(:link_or_button, 'Mark as Unread')
      click_on "Mark as Read"

      expect(current_path).to eq "/links"
      expect(page).to have_content "Marked link #{title} as read!"

      within(".links") do
        expect(page).to have_css(".read")
      end
    end
  end

  context "link has read status" do
    scenario "sees link become unread" do
      title = "Capybara fun"
      url = "http://giphy.com/gifs/party-pool-capybara-ddUrtZA5JZD6E"
      user = login_user
      link = user.links.create(title: title, url: url, read: true)

      visit "/links"
      expect(page).to_not have_selector(:link_or_button, 'Mark as Read')
      click_on "Mark as Unread"

      expect(current_path).to eq "/links"
      expect(page).to have_content "Marked link #{title} as unread!"

      within(".links") do
        expect(page).to have_css(".unread")
      end
    end
  end
end
