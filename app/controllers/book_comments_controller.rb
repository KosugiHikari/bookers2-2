class BookCommentsController < ApplicationController
  
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    if comment.save
      redirect_to book_path(book)
    else
      book = Book.find(params[:book_id])
      comment = current_user.book_comments.new(book_comment_params)
      comment.book_id = book.id
      render book_path(book)
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    BookComment.find(params[:id]).destroy
    redirect_to book_book_comments_path(@book)
  end
  
  private
  
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
