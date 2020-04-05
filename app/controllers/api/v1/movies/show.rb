module API
  module V1
    module Movies
      class Show < Grape::API
        route_param :id, type: Integer, desc: "Movie id" do
          params do
            optional :with_genre, type: Boolean, default: false, desc: "Present with genre"
          end
          get do
            movie = Movie.includes(:genre).find(params[:id])

            present movie, with: API::Entities::Movie, with_genre: params[:with_genre]
          end
        end
      end
    end
  end
end
