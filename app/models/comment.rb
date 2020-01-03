# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :text, :user_id, presence: true
  validates :text, length: { maximum: 300 }
end
