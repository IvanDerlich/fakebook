require 'rails_helper'

RSpec.describe Comment, type: :model do    
    
    let(:comment) {
        FactoryBot.create(:comment)
    }

    it '# creates a valid comment' do
        expect(comment).to be_valid
    end

    it '# invalid comment with no text ' do
        comment.text = nil
        expect(comment).to_not be_valid
    end

    it '# invalid blank comment' do
        comment.text = ""
        expect(comment).to_not be_valid
    end

    it '# invalid comment with text longer than 300 characters ' do
        comment.text = Faker::Lorem.paragraph_by_chars(number: 301, supplemental: false)
        expect(comment).to_not be_valid
    end    

    it '# invalid postless comment' do
        comment.post = nil
        expect(comment).to_not be_valid
    end

    it '# userless comment ' do
        comment.user = nil
        expect(comment).to_not be_valid
    end   
end