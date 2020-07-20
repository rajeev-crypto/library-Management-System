class BooksController < ApplicationController
  
  before_action :require_login # move to application controller
  before_action :require_librarian, only: [:new, :create, :edit, :update, :overdue]

  def index
    @user = nil
    #@books = []
    if params.include? :user_id
      @user = User.find(params[:user_id])
      redirect_to root_path if @user != current_user
      @books = Book.checked_out(@user.id)
    else
      @books = Book.all
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id]) # move to a before action
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.update(book_params)
      @book = book.destroy
      redirect_to book_path(@book)
    end
  end
  
  def show
    @book = Book.find(params[:id])
    @user = current_user
  end


  def overdue
    @books = []
    Book.all.each do |book|
      if book.check_out_logs.last
        @books << book if (book.check_out_logs.last.overdue? && book.present_user_id != nil)
      end
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author_id, :genre_id, :checked_out, :present_user_id)
  end

end
