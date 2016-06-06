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

  context "change link with invalid title" do
    scenario "sees re-rendering of form" do
      title = "Capybara fun"
      url = "http://giphy.com/gifs/party-pool-capybara-ddUrtZA5JZD6E"
      new_title = ""
      new_url = "http://giphy.com/gifs/funny-panda-cute-animals-sB4nvt5xIiNig"
      user = login_user
      link = user.links.create(title: title, url: url)

      visit "/links"

      click_on "Edit link"
      fill_in "Title", with: new_title
      fill_in "Url", with: new_url
      click_on "Edit link"

      expect(page).to have_content "Your link update was invalid!"

      visit "/links"
      within("#link-#{link.id}") do
        expect(page).to have_link(title, href: url)
        expect(page).to_not have_link(new_title, href: new_url)
      end
    end
  end

  context "change link with invalid url" do
    scenario "sees re-rendering of form" do
      title = "Capybara fun"
      url = "http://giphy.com/gifs/party-pool-capybara-ddUrtZA5JZD6E"
      new_title = "New title"
      new_url = "not a valid url"
      user = login_user
      link = user.links.create(title: title, url: url)

      visit "/links"

      click_on "Edit link"
      fill_in "Title", with: new_title
      fill_in "Url", with: new_url
      click_on "Edit link"

      expect(page).to have_content "Your link update was invalid!"

      visit "/links"
      within("#link-#{link.id}") do
        expect(page).to have_link(title, href: url)
        expect(page).to_not have_link(new_title, href: new_url)
      end
    end
  end
end
