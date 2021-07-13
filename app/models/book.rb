class Book < ApplicationRecord 
	belongs_to :user
	validates :title, presence: true
	validates :body ,presence: true, length: {maximum: 200}
	
	validates :rate, numericality: {
	  less_than_or_equal_to: 5,
	  greater_than_or_equal_to: 1,
	}, presence: true

  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  def favorited_by?(user)
    Favorite.where(user_id: user.id, book_id: self.id).exists?
  end
end
