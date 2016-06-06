# As an authenticated user who has added links to my Thoughtbox, when I view the link index:
#
# Next to each unread link I should see an option to "Mark as Read".
# Clicking this should update the link appropriately and take me immediately back to the my links.
# Next to each read link I should see an option to "Mark as Unread".
# Clicking this should update the link appropriately and take me immediately back to the my links.
# Read links should be stylistically differentiated from unread links. You could gray them out or use a strike through.
# Note: Later iterations will require that you be able to update the status of the link without reloading the page. Depending on your approach, it might be easier to implement that now.

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
end
