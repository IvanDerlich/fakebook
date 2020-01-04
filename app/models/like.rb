# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  #validates that there is no other post with the same combination of user_id and post_id
end
