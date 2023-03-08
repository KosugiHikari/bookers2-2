class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  # ソート機能使わずに１週間以内のいいね数が多い順に並べるのはこっち↓
  # has_many :week_favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'

  has_many :view_counts, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  validates :tag, presence:true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search_for(content, method)
    if method == "perfect_match"
      Book.where("title LIKE?", "#{content}")
    elsif method == "forward_match"
      Book.where("title LIKE?", "#{content}%")
    elsif method == "backward_match"
      Book.where("title LIKE?", "%#{content}")
    elsif method == "partial_match"
      Book.where("title LIKE?", "%#{content}%")
    end
  end
end
