class AuthorsController < ApplicationController

  before_action :require_login
  before_action :require_librarian, only: [:new, :create, :edit, :update]

  def index
    @authors = Author.all
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      redirect_to author_path(@author)
    else
      render :new
    end
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])
    if @author.update(author_params)
      redirect_to author_page(@author)
    else
      render :edit
    end
  end

  def show
    @user = current_user
    @author = Author.find(params[:id])
  end

  private

  def author_params
    params.require(:author).permit(:name, :deceased)
  end
end
