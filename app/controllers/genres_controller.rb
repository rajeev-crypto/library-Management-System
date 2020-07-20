class GenresController < ApplicationController

  before_action :require_login
  before_action :require_librarian, only: [:new, :create, :edit, :update]

  def index
    @genres = Genre.all
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to genre_path(@genre)
    else
      render :new
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to genre_path(@genre)
    else
      render :edit
    end
  end

  def show
    @user = current_user
    @genre = Genre.find(params[:id])
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end