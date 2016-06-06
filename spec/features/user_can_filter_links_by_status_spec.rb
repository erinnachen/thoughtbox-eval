require 'rails_helper'

RSpec.feature "Logged in user can filter links by status" do
  include SpecHelpers

  scenario "sees only read links", :js => true do
    title = "Capybara fun"
    url = "http://giphy.com/gifs/party-pool-capybara-ddUrtZA5JZD6E"
    title2 = "amazing pandas"
    url2 = "http://giphy.com/gifs/funny-panda-cute-animals-sB4nvt5xIiNig"
    user = login_user
    link = user.links.create(title: title, url: url, read: true)
    link2 = user.links.create(title: title2, url: url2)

    visit "/links"
    within(".links") do
      expect(page.first(:css, ".link")).to have_link(title, href: url)
      expect(page).to have_link(title2, href: url2)
    end
    click_on "Only read links"

    within(".links") do
      expect(page).to have_link(title, href: url)
      expect(page).to_not have_link(title2, href: url2)
    end
  end

  scenario "sees only unread links", :js => true do
    title = "Capybara fun"
    url = "http://giphy.com/gifs/party-pool-capybara-ddUrtZA5JZD6E"
    title2 = "amazing pandas"
    url2 = "http://giphy.com/gifs/funny-panda-cute-animals-sB4nvt5xIiNig"
    user = login_user
    link = user.links.create(title: title, url: url, read: true)
    link2 = user.links.create(title: title2, url: url2)

    visit "/links"
    within(".links") do
      expect(page.first(:css, ".link")).to have_link(title, href: url)
      expect(page).to have_link(title2, href: url2)
    end
    click_on "Only unread links"

    within(".links") do
      expect(page).to_not have_link(title, href: url)
      expect(page).to have_link(title2, href: url2)
    end
  end
end
