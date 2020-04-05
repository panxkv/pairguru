module API
  module V1
    module Movies
      class Index < Grape::API
        params do
          optional :with_genre, type: Boolean, default: false, desc: "Present with genre"
        end

        get do
          present Movie.all.includes(:genre),
                  with: API::Entities::Movie,
                  with_genre: params[:with_genre]
        end
      end
    end
  end
end
