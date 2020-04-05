class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]
  before_action :find_movie, only: [:show, :movie_data, :movie_poster]

  def index
    @movies = Movie.paginate(page: params[:page]).decorate
  end

  def show; end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_now
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(current_user, file_path)
    redirect_to root_path, notice: "Movies exported"
  end

  def movie_data
    @movie_data = MovieImporter.call(@movie.title)
    render partial: "movie_data"
  end

  def movie_poster
    @movie_data = MovieImporter.call(@movie.title)
    render partial: "movie_poster"
  end

  def find_movie
    @movie = Movie.find(params[:id])
  end
end
