class BookCommentsController < ApplicationController
  
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    session[:previous_url] = request.referer
    comment.save
    redirect_to session[:previous_url]
  end
  
  def destroy
    session[:previous_url] = request.referer
    BookComment.find(params[:id]).destroy
    redirect_to session[:previous_url]
  end
  
  private
  
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
  
end
