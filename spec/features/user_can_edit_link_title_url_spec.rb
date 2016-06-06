# As an authenticated user who has added links to my Thoughtbox, when I view the link index:
#
# Each link has an "Edit" button that either takes me to a page to edit the link or allows me to edit the link in place.
# I can edit the title or the URL of the link.
# I cannot change the URL to an invalid URL.
require 'rails_helper'

RSpec.feature "Logged in user can edit links" do
  include SpecHelpers

  context "change link with valid title and url" do
    scenario "sees link title and url change" do
      title = "Capybara fun"
      url = "http://giphy.com/gifs/party-pool-capybara-ddUrtZA5JZD6E"
      new_title = "New title"
      new_url = "http://giphy.com/gifs/funny-panda-cute-animals-sB4nvt5xIiNig"
      user = login_user
      link = user.links.create(title: title, url: url)

      visit "/links"

      click_on "Edit link"
      fill_in "Title", with: new_title
      fill_in "Url", with: new_url
      click_on "Edit link"

      expect(current_path).to eq "/links"
      expect(page).to have_content "Your link was updated!"

      within("#link-#{link.id}") do
        expect(page).to_not have_link(title, href: url)
        expect(page).to have_link(new_title, href: new_url)
      end
    end
  end
end
