require 'rails_helper'

RSpec.feature "User can logout" do
  include SpecHelpers

  scenario "sees login page" do
    user = login_user
    visit '/links'
    click_on "Sign Out"

    expect(current_path).to eq '/login'
  end
end
