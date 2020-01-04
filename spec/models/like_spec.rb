require 'rails_helper'

RSpec.describe Like, type: :model do 

    let(:like) {
        FactoryBot.create(:like)
    }

    it '# creates a valid like' do
        expect(like).to be_valid
    end

    it '# invalid like that belongs to user but not to a post' do
        like.post = nil
        expect(like).to_not be_valid
    end

    it '# invalid like that belongs to post but not to a user ' do
        like.user = nil
        expect(like).to_not be_valid
    end

    it '# invalid like that neither to a post nor to a user ' do
        like.post = like.user = nil
        expect(like).to_not be_valid
    end   

end