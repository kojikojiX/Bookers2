class Book < ApplicationRecord
	validates :title, presence: true
	validates :body, presence: true, length:  { maximum: 50 }
	belongs_to :user
end