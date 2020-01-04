require 'rails_helper'

# Change this ArticlesController to your project
RSpec.describe PostsController, type: :controller do
	
	user = FactoryBot.create(:random_user)
	login_user(user)

	let(:valid_post_attributes) {
		{
			text: "This is a test description"
		} 
	}

	let(:valid_session) { {} }

	describe "GET #index after create post" do
		it "returns http status 302" do
			#Post.create! valid_post_attributes
			user.posts.build(valid_post_attributes)
			get :index, params: {}, session: valid_session
			expect(response).to have_http_status(302) # be_successful expects a HTTP Status code of 200
			#expect(response).to have_http_status(302) # Expects a HTTP Status code of 302
		end
	end
end