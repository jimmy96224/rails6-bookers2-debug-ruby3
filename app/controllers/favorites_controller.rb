class FavoritesController < ApplicationController
  
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    session[:previous_url] = request.referer
    favorite.save
    redirect_to session[:previous_url]
  end
  
  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    session[:previous_url] = request.referer
    favorite.destroy
    redirect_to  session[:previous_url]
  end
  
end
