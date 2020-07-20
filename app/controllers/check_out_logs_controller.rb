class CheckOutLogsController < ApplicationController

  before_action :require_standard_user

  def new
    @book = Book.find(params[:book_id])
    @user = current_user
    @check_out = CheckOutLog.new
  end

  def create
    book = Book.find(params[:check_out_log][:book_id])
    if book.checked_out
      flash[:notice] = "This book has already been checked out."
      render book_path(book)
    else
      CheckOutLog.create(check_out_log_params)
      book.checked_out = true
      book.present_user_id = params[:check_out_log][:user_id]
      book.save
      redirect_to user_path(current_user)
    end
  end

  def check_in
    user = current_user
    book = Book.find(params[:book_id])
    if !book.checked_out
      flash[:notice] = "This book is not checked out."
      render book_path(book)
    elsif (book.checked_out && (book.present_user_id == user.id))
      check_in = CheckOutLog.find(params[:id])
      check_in.check_in_date = Date.today
      book.checked_out = false
      book.present_user_id = nil
      check_in.save
      book.save
      redirect_to user_path(user)
    else
      flash[:notice] = "This book is not checked out to you."
      render book_path(book)
    end
  end

  private

  def check_out_log_params
    params.require(:check_out_log).permit(:book_id, :user_id, :comment, :check_out_date)
  end
end
