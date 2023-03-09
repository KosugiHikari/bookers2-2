class Tag < ApplicationRecord
  has_many :book_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :books, through: :book_tags
  
  scope :merge_books, -> (tags){ }
  
  def self.search_books_for(content, method)
    
    if method == 'perfect_match'
      tags = Tag.where(name: content)
    elsif method == 'forward_match'
      tags = Tag.where("name LIKE?", "#{content}%")
    elsif method == 'backward_match'
      tags = Tag.where("name LIKE?", "%#{content}")
    else
      tags = Tag.where("name LIKE?", "%#{content}%")
    end
    
    return tags.inject(init = []) {|result, tag| result + tag.books}
    
  end
      
end
