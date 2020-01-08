# frozen_string_literal: true

FactoryBot.define do
  module ControllerMacros
    def login_user(user)
      # Before each test, create and login the user
      before(:each) do
        @request.env['devise.mapping'] = Devise.mappings[user]
        sign_in user
      end
    end
  end
end
