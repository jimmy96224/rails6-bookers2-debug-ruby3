class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  before_action :ensure_correct_user, only: [:edit, :update]
  

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @book_detail = Book.find(params[:id])
      unless ViewCount.find_by(user_id: current_user.id, book_id: @book_detail.id)
        current_user.view_counts.create(book_id: @book_detail.id)
      end
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
    @books = Book.all
  end

  def edit
    @user = current_user
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
