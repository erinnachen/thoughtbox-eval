require "rails_helper"

RSpec.describe "PATCH api/v1/links/:id" do
  it "returns a 204 status" do
    title = "Capybara fun"
    url = "http://giphy.com/gifs/party-pool-capybara-ddUrtZA5JZD6E"
    user = create(:user)
    link = user.links.create(title: title, url: url, read: true)

    patch "/api/v1/links/#{link.id}", link: {read: false}

    expect(response.status).to eq 204
  end
end
