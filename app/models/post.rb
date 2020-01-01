# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  validates :text, :user_id, presence: true
  validates :text, length: { in: 15..300 }
end
