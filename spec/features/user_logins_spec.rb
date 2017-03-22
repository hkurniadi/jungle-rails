require 'rails_helper'

RSpec.feature "Visitor logs in", type: :feature, js: true do

  # SETUP
  before(:each) do
      @user = User.create!(
        first_name: 'Ken',
        last_name: 'Do',
        email: 'doken@email.com',
        password: 'qwertyqwerty',
        password_confirmation: 'qwertyqwerty'
      )
  end

  scenario "They are redirected to home page" do
    # ACT
    visit new_session_path
    fill_in 'email', with: 'doken@email.com'
    fill_in 'password', with: 'qwertyqwerty'
    click_button 'Login'

    # # DEBUG / VERIFY
    save_screenshot
    expect(page).to have_css 'section.products-index'
  end

end
