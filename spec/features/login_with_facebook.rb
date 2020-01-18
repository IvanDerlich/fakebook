# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login with Facebook', type: :feature do
  RSpec.configure do |c|
    c.include OmniauthHelper
  end

  before(:each) do
    OmniAuth.config.mock_auth[:facebook] = nil
  end

  scenario '# successfull login' do
    stub_omniauth
    visit new_user_session_path
    expect(page).to have_link('Sign in with Facebook')
    click_link 'Sign in with Facebook'
    expect(page).to have_content('Joe')
    expect(page).to have_link('Log out')
  end

  scenario '# unsuccessful login' do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    visit new_user_session_path
    expect(page).to have_link('Sign in with Facebook')
    click_link 'Sign in with Facebook'
    expect(page).to have_link('Sign in with Facebook')
  end
end
