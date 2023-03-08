class TagSearchesController < ApplicationController
  def search
    @model = Book
    @word = params[:word]
    @books = Book.where(tag: @word)
    render "searches/search"
  end
end
