class Post < ApplicationRecord
  belongs_to :user
  belongs_to :sub

  validates :title, presence: true
  validates :title, uniqueness: true
  
end
