# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User-Likes-Post', type: :feature do

	let(:post) { FactoryBot.create(:random_post)}
	let(:user) { FactoryBot.create(:random_user)}
	let(:users5) { FactoryBot.create_list(:random_user,5) }
	let(:posts5) { FactoryBot.create_list(:random_post,5) }
	let(:posts2) { FactoryBot.create_list(:random_post,2) }

	scenario '# post gets a user to like it' do
		like = user.likes_post post
		expect(like).to be_valid
	end

	scenario '# post gets 5 users to like it' do
		users5.each{ |u|
			like = u.likes_post post
			expect(like).to be_valid
		}
	end

	scenario '# user likes 2 posts' do
		posts2.each{ |p|
			like = user.likes_post p
			expect(like).to be_valid
		}
	end

	scenario '# user likes 5 posts' do
		posts5.each{ |p|
			like = user.likes_post p
			expect(like).to be_valid
		}
	end

	scenario '# user likes the same post twice and gets an error message' do
		like1 = user.likes_post post
		like2 = Like.new
		like2.user = user
		like2.post = post
		like2.valid?
		expect(like2).to_not be_valid	
	end

end
