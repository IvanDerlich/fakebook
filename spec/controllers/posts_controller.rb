require 'rails_helper'

# Change this ArticlesController to your project
RSpec.describe PostsController, type: :controller do
    
    # let(:user){
    #     User.create!(
    #         :first_name => "Ignacio",
    #         :last_name => "Loyola",
    #         :email => "nacho@example.com",
    #         :phone_number => "0303456",
    #         :password => "laralala"
    #     )
    # }
    user = FactoryBot.create(:user)
    login_user(user)

    let(:valid_post_attributes) {
        {
            :text => "This is a test description" ,
            :user => user
        } 
    }

    let(:valid_session) { {} }

    describe "GET #index" do
        it "returns a success response" do
            Post.create! valid_post_attributes
            get :index, params: {}, session: valid_session
            expect(response).to be_successful # be_successful expects a HTTP Status code of 200
            #expect(response).to have_http_status(302) # Expects a HTTP Status code of 302
        end
    end
end