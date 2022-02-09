require 'rails_helper'

RSpec.feature "UserLogins", type: :feature do
  before :each do
    @user = User.create! first_name: 'Jim', last_name: 'Testman', email: 'jim@testman.com', password: 'password'
  end

  scenario "They should be able to login" do
    visit '/login'
    fill_in 'Email', with: 'jim@testman.com'
    fill_in 'Password', with: 'password'
    find('input.btn-primary').click
    expect(page).to have_content('Logout')
    save_screenshot
  end
end
