class Comment < ApplicationRecord
  belongs_to :event
  validates :content, presence: true
  validates :user_name, presence: true
end
