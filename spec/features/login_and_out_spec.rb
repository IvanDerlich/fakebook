# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Log in and out', type: :feature do
  let(:user) { FactoryBot.create(:random_user) }

  scenario '# successfull login followed by logout' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content('All posts')
    click_on 'Log out'
    expect(page).to have_content('Log in')
  end

  scenario '# unsuccessful login' do
    visit new_user_session_path
    fill_in 'Email', with: 'incorrectemail@exsd.com'
    fill_in 'Password', with: '123'
    click_button 'Log in'
    expect(page).to have_content('Invalid Email or password.')
  end
end
