# As an authenticated user viewing the main page (links#index), I should see a simple form to submit a link.
#
# The Link model should include:
#
# A valid URL location for the link
# A title for the link
# Additionally, all links have a read status that is either true or false. This column will default to false.
#
# Submitting an invalid link should result in an error message being displayed.
#
# Hint: Use Ruby's built in URI.parse method to determine if a link is a valid URL or not. This StackOverflow post has more information. Alternatively, you could use a gem like this one.
#
# Once a link has been submitted, loading the index page should display all of my links.

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
      click_on "Add link"

      visit "/links"
      within(".links") do
        expect(page).to have_link(title, href: url)
      end
    end
  end
end
