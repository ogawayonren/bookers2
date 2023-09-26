class BooksController < ApplicationController
   before_action :is_matching_login_user, only: [:edit, :update]


    # 投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    @user = @book.user

    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to books_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end


  def edit
    @book = Book.find(params[:id])
  end

  def index
    @book = Book.new
    @books = Book.all
    @user =  User.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
    redirect_to book_path(book.id)
    else
      render :edit
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def destroy
    book = Book.find(params[:id])
    book.delete
    redirect_to books_path
  end

  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
end










