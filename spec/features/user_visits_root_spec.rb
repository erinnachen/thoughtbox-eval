require 'rails_helper'

RSpec.feature "User visits '/'" do
  scenario "sees two buttons for either loggin in or signing up" do
    visit '/'
    expect(page).to have_selector(:link_or_button, 'Log in')
    expect(page).to have_selector(:link_or_button, 'Sign up')
  end
end
